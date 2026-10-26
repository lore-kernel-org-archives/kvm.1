Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986271;
	b=t4hKzbLjEleh8mU9DlOKqBmaC3+E5tAyBWzrGogn5kpbc2oJzUgIlmqXepbXvHVSxZSn
	 DlEDRleqthVMWdCAsgYcFCDvWPFXAzrJmoBqun2UyoJbiz7HhYos2dK41XSgpMGDgmqGs
	 9Jg3tNHQiPKex/WdoAy7St5eYbxrnPkAP/EajFWslSkKcioWFBr1NbIiQpqfA5GmEByqI
	 gpzH4PS7xm0HAr8i3mTvJDbjyC9EQiSEgBYnuayq4hEbUNizz2FQhLbix9S2JMb6UvVqX
	 5wffXI3byCG5BrFzjZ6pe4YZT2237dbylj6yW1z0TWBrvmH00HrLbYLiEUub7rzBHqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FuZU9Bm4L1tjpR5OE6ZUvzPtHgo0PRLa1bH4/fzLGaA=;
	b=ImtYfmd8DixjRj6yLf62T248iPYYeYKRAge+H7M9LKoJwK33MjMWXYB9OEz4kA36k0V5
	 Udk50NINp9UvKyfs9RH5Ai11g0Rdr+HqLd1yMk8QtQtZkQ4+Dlp3n/Vth9VfkN7jGiiOm
	 qc1BPfoOnt1123vjmw++mg/IuErWNW9W1GetIrBGG1F9lL2LMZ1Mlzxl9kbahkiSkGOuZ
	 G9UiaJqF33Qc/8bpihi72ikIDH120clbDFYjlLgQLXPM9X/KZILOvCxZ69XZKPqLfOn4g
	 VWzQfCTvXwq2ZQ0wVbXhCE/5VBoxAfkYOYloZz31d/6G49DeHYWyNUw6lW0KUElZOEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XFeqDJ3a;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84080606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 03:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84080606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XFeqDJ3a
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5361e313e63so24634951cf.3
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792986270; x=1793591070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FuZU9Bm4L1tjpR5OE6ZUvzPtHgo0PRLa1bH4/fzLGaA=;
        b=XFeqDJ3aqCLfK8rrrOUKshScqKQbmpP2YKgSEkoMcDpM1IGtiD9AxmIQ4pb97xtnzW
         wF8WVlBAxgPHE13QC9fwkToonYBTQroVIa+N8zTzWLWUbJ1A2o5s8mArhBb2AqPnMlX0
         edRMOh3Wr01dtJsTWl1AClAKCJRFUFd2Pi6xti/P+EstLXMOF45iDByRyEzccHlViIip
         ShHDZX/cm+8UcpgoRtTkDKRgMGmfr/R9uv41GxiiQnRbfB8drvGTaS4dH3IvurK80yPR
         2L68p1pDbKpFdrgJ+qe4UeLMbASOFKO5aw9B6fFKliCmVCKOj69P7JY8ct9ivfFCSAz7
         qaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792986270; x=1793591070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuZU9Bm4L1tjpR5OE6ZUvzPtHgo0PRLa1bH4/fzLGaA=;
        b=doCUUc1chF95dZE8UZXIomXipZSO8SQngrNWZBH6JGaY1lBhqu1NR3RAyWZoCEnQL8
         K88FAa7V0Ma4Dbn9SGokq+74B+6zCaNvfVNP5QqGFh82kjnf019Jt17ZIoBxMPE8kPq9
         jaWS68soX/BOZQE5/k4V0rwPhNQMNBvZidTPVZlEKFQSDMXJYZXzA6ntY1y1kJcDVs1a
         yl5UmKU7lJEMKU8rELK+TK7hjv0yNB8EjDO98rL2TMBgwPCAZhiFBZA+gBNyQwMoARQZ
         JpqMESiCkKn9QGN7mT1E1ClvfOQahOJetUEnbehjHzA6V82T7yNcMkAXa2VlHQn7TL9R
         l5xQ==
X-Gm-Message-State: AFq9FYKciHJzZV3rWucsOMvvdStuBh7f/d9gVxbMXyPXi3ul+WplUPx3
	5WBqWKxRmflF7VO12V4+XiCGjd1XCRY1QwvlZwh39X5rAVQA/1aAN630Elgn8w==
X-Gm-Gg: AYBFou3pB/qMgIQeQjuJuQgQeilzK2+sIX7ujdCxRt9wSXQSI/opDvMLHXG8uIQPVg9
	Tl8QETFkQ7Fw4jzo9rItOp1MfvDWn3bJXegLHuoukN41Dh4hyrT8lTLYwlVrqtAnOj9VmmQyBTR
	Y3R56XBbk6P2TBVAyOVBUbVxzC+mbgsRXAxAsiF+ApzMway60uxpQ36/QU3ZA3iLKVV1/wu/4Sq
	orUlcu7Vm9S+2D2ZIb+gpS1HFUvhQXBEv5jpV4gqc08dYsBPcHTiDBiOwyV+i2bX0uxI1A0ww95
	5fl9QJnVCslcdXGgoka5hTCAe8O2PHuD6VQXGHANsQRe8w3UwcOoLnwQolqyvAmbZawly31xGDB
	5vCnxAtsH+IPQ6GzUfeyYNwp4dtrXjstGbeYLfon+yEe2eWEcwzt1pmfd30vH3o0fh1XkdhIp0o
	EoaDhlQdpX6PBGq0XHNvHXhOWpMA+gUbSiKelaXmL/85pmrca488e9gqsZGVSriLYlpgHa/ebP2
	MaYigt3sR+7xxPSmNGnsDLzLIOPxN4GVasWxY9orcCnQc+K6/dl9dczoH2cskaE9d/CdoHDJztT
	Sl6+HDtG7uMx8xPiinYDyvZSaCXiw4JWwpF3OwHS3pXhv/9y6eHZfXNxGl3Q
X-Received: by 2002:ac8:6546:0:b0:536:699d:9a1c with SMTP id d75a77b69052e-5383b3509cdmr79585421cf.2.1792986270529;
        Sun, 25 Oct 2026 20:44:30 -0700 (PDT)
Received: from paul-white-HP-Pavilion-Laptop-15-cs1xxx.mynetworksettings.com ([2600:4040:ad65:1c00:4cc4:d0be:4ab6:9a0b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c5273sm46202121cf.9.2026.10.25.20.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:44:30 -0700 (PDT)
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
Subject: [PATCH 0/2] KVM: riscv: Unify and optimize FP register loops
Date: Sun, 25 Oct 2026 23:41:25 -0400
Message-ID: <cover.1792982932.git.paul.white.kernel@gmail.com>
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

Paul White (2):
  KVM: riscv: Eliminate redundancy in get_reg function via pointers
  KVM: riscv: Eliminate redundancy in set_reg function via pointers

 arch/riscv/kvm/vcpu_fp.c | 128 +++++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 52 deletions(-)

-- 
2.53.0

