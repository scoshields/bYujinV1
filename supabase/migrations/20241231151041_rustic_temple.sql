/*
  # Update exercises table to allow null values

  1. Changes
    - Make grip and mechanics fields nullable
    - Keep existing grip and mechanics validation
*/

-- Drop existing exercises table
DROP TABLE IF EXISTS exercises CASCADE;

-- Recreate exercises table with nullable fields
CREATE TABLE exercises (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  target_muscle_group text NOT NULL,
  primary_equipment text NOT NULL,
  grip text CHECK (
    grip IS NULL OR grip IN (
      'Neutral',
      'No Grip',
      'Flat Palm',
      'Head Supported',
      'Pronated',
      'Forearm',
      'Crush Grip',
      'Supinated',
      'Bottoms Up',
      'Hand Assisted',
      'Goblet',
      'Horn Grip',
      'Bottoms Up Horn Grip',
      'False Grip',
      'Other',
      'Waiter Hold',
      'Mixed Grip',
      'Fingertip'
    )
  ),
  mechanics mechanics_type,
  video_link text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Exercises are readable by all"
  ON exercises FOR SELECT
  TO authenticated
  USING (true);

-- Here's a template for inserting exercises:
COMMENT ON TABLE exercises IS 'Example insert:
INSERT INTO exercises (
  name,
  target_muscle_group,
  primary_equipment,
  grip,
  mechanics,
  video_link
) VALUES (
  ''Barbell Bench Press'',
  ''Upper Chest'',
  ''Barbell'',
  ''Pronated'',
  ''Compound'',
  ''https://example.com/bench-press''
);';