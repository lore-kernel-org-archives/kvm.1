Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227406;
	b=OIC8fDetYWfJlK3/8jQmFFfCubbMAx3OtZGLGv1M/CfTVOvTvFVKp6hxUrwbycFUP/sm
	 G6ALEUWM03Ok6wr+8XGBU76vZ8R3FgekdJ6Rsyk7EOSslT6coikKaGL59UerPV1jC5TZw
	 tnPGPdl072ufl/DLQzeYzRUn0apIgaJPIgzblq0Dnb1ap7oqXxNzO9jt3HJUFxU+Ae/r+
	 ekjWkt4SZbideENOakAmKF9mgAzlS2Igd9ZqBAOYb7yJKbd48SOup+L0rHVb6IqXrk/YI
	 ysOnhOAf4T84CdB40XjCytVR9ucEGleSOOmOMNriuCXHZhT4YJZ2z4dCko+fwxQ6udg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yECpefA28/MXqj384Qufm+rtjJRCtVDFYCVrS7mE970=;
	b=YfPqDsS9zLzOP4X+BXDmIUT/loAYuoVuAlqPY+ikrM8Pi3Fov2uhPSgozP+S1LG5rs16
	 IT1qzlT9wa0sXJYNJGdXkW2LM4x27adYzmeXqGKTFa+q1Cv4D6nHmwdeGmqD1rvKQF0XT
	 UXfLDElzezZExXNxEWvY59cfmDfZUUJ9UjiN6mzYGEUo1EfvnU2S7rwCvDgNh+O6jwBW0
	 irDBue9jCZC6xYaVp4RkdDvmWkuh2cV8xrs3bhJmdbE1uzcd0Yd08ZQ2BEzdr/5fHIiyR
	 So3eDO7xNTfp70EzAY3HBOknNC0dD0dhsmgAfxgZmbA3HWc8CdHtwTXmJbljbjaQ7kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQp4S+Vq;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4661606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 22:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4661606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lQp4S+Vq
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91791ec1b83so12602366d6.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793227405; x=1793832205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yECpefA28/MXqj384Qufm+rtjJRCtVDFYCVrS7mE970=;
        b=lQp4S+VqbSlQwdzBwvFGFKLSCJ33FEcbI1/XWwziY202gcLj+wWke+uOTIsLXFcZEZ
         OgF+l4vw4UYlH6RpbYRfsqyTouyxsFPjHes0lycbvwj3HxE0UFQS8UQokqfwjsXub8fk
         AWevC0K4eg9MhctNn/xfll6H056bR2tWkwr1dKUP9Ms/AtLrCZdwBMtvToPp1kMYZ2uh
         o6uwv4sqkR665mDVdxrs2tNh5SJ8exG8q+xqo410R3uDb14KVPEFTU52sT0+/qqFvHCK
         kuUEYlU7KJhLVIcRL31RF80b+imUNo7+il5ClzD6V1b2QebCqGuLUX9KC8vm1HMF+n6/
         T56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793227405; x=1793832205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yECpefA28/MXqj384Qufm+rtjJRCtVDFYCVrS7mE970=;
        b=Wtb+GbeLBqqzPmpfPgR7UnVpA79bAhGDN2PtXNYzGu0eRyKuDEUgiUggE6j5j2n1OX
         yXDeo/GmIJCwuv/ylThVQDPENXjDSGfqd/ALL5a65NbZfhjLE1Uss5Q0w0LMoZqRwBY/
         CFtZly6NA4C8+Z4jsJXqiD3LECesuNnJizkWA4+Pwj54R4R7WY1TT4PP5gGCgoT37mK1
         VaNp2lIvHRlXIStuOho955yFDbOAJVJXDOdLuPTzNQQEEeMcL4XmtAD151blfYJv93R9
         gR4OJJvDJJ9PpByFXVPQt18XzRIv4O1waMsV750cL+NCYtM7bJ72auvsln4sqCWb/3SO
         AfSg==
X-Gm-Message-State: AFq9FYKap9nLwbcQaMRRkX546aHlPQ25+kHWLr/ACFK4oAFb6dlEPWFj
	JLcGgIQI3M3+J3Qe8qG8oAKxZDlHlDT8n+bqMkAMd8ZitDldcmcXhh1s
X-Gm-Gg: AYBFou3LvUqXoaEC5Fpk0IwbTwIc2mGgRaGg8rVDcWbuUK3Z2hanJplYcNxsCDILU30
	7nqIyfbRzEN0PhoiME2vuSWc1xCoak1sTc9WE07nnVIe4vIaRBm6k1CJEUDUExhsi/N1xZMc7d3
	H4Lf2A/EwW1URNAFtFqVYun8XZU1h7Ssu6bIl2J7jdzWDQVR+kHBtHyo3/IER9WQnQtSorfRU7G
	P/bTgY14SDtUVmtjiWkByK0FdwYmWBzd8aFAzbpLafRsUUBqfQN9IeZ5GFbWCEvgbELVkIcyv35
	B8paE/wqr433D9VuYl+jPGuEmrwlNA/3ocdm9Cdi8o2xUuulfiLyPNAmdshJ5Tiee2GPAY3XmVZ
	Q/kePE4eNwi2RdP/czkl+c64xhG/fSR8OkFXtBszbsQu4zrxL1GzN7L19jDv9edatMaokKItplB
	2UJvTWliM/s8r5I38J/7rpGAmLwXqFok0uC2UDgUWFi4cKtsTjB4mpjAHrJbwLQASjkMx28tn04
	nKfyTOEX0DN7QXbVLnHcruzlJVbpbTT8FZUJaHrv3UMOvtB+FTli97LFOf/9GhRpgR4g0cA2WW9
	duBc2HhdbqSX9uGxWw9dXebnAWLNzIopTDlke+sGMc860oLjLDwecBzmhn7LDuZ/VmC0TDALifS
	XNTstWsAhZPtNhybsT8Wyvm70QP6e8N7155ov4iBXcR78df5yrpM=
X-Received: by 2002:a05:620a:26a1:b0:93e:c12c:fbc8 with SMTP id af79cd13be357-94408d361damr565214385a.68.1793227404758;
        Wed, 28 Oct 2026 15:43:24 -0700 (PDT)
Received: from paul-white-HP-Pavilion-Laptop-15-cs1xxx.mynetworksettings.com ([2600:4040:ad65:1c00:b8:5aeb:4bda:886])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0787d96sm1370085685a.28.2026.10.28.15.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:43:24 -0700 (PDT)
From: Paul White <paul.white.kernel@gmail.com>
To: anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Paul White <paul.white.kernel@gmail.com>
Subject: [PATCH v2 0/2] KVM: riscv: Unify and optimize FP register loops
Date: Wed, 28 Oct 2026 18:43:07 -0400
Message-ID: <cover.1793223506.git.paul.white.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change to both patches in this series is a 
structural/architectural one. Both functions set_reg and get_reg use 
identical code to locate the register the application specified in the 
token even though they do different things with that location 
information: the set_reg function adds data the application requested 
to send to that identified location  (in the copy_from_user function) 
while the get_reg function retrieves what data is at that identified 
location and sends it to the application (using the copy_to_user 
function). Everything else is the same. That is the only difference 
between the code. 

Therefore I was able to apply the same solution to both of the 
function's finding-the-requested-register parts (which is everything 
up until the final if statement) which were filled with redundancy. 
The solution I came up with is to create local variables for the 
entire function for all the variables of the original code that would 
be different, depending on the floating point type. Then once I ask 
whether it is a double floating point or single floating point mode, I 
assign the aforementioned variables to the values they should have for 
that mode so that when I go through the if statements that ask whether 
the requested register number is a status control register or data 
register, I only have to go through it once because the respective 
floating point values/addresses would have been assigned to the 
aforementioned local variables, so the whole code kind of changes or 
is tailored to the floating point type. 

This architectural change/solution will make the cpu execute the code 
faster (as the cpu will have less decisions to make and the bare-metal 
math used to figure out the address of the register is executed faster 
by the cpu than looking up object properties and array indexes), is 
more maintainable, and is more readable.

---
v2: 
  - Both patches had the same flawed line of code. The checking if the 
    token's size was 32 or 64 bits line allowed token's with mismatched 
    sizes & types to pass. I fixed this by checking it had the right 
    size for its type by replacing the u32/u64 parts with a 
    mode-dependent local variable, byte_offset. 

Paul White (2):
  KVM: riscv: Eliminate redundancy in get_reg function via pointers
  KVM: riscv: Eliminate redundancy in set_reg function via pointers

 arch/riscv/kvm/vcpu_fp.c | 124 +++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 52 deletions(-)

-- 
2.53.0

