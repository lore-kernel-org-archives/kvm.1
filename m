Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546903;
	b=kRsOPupEcnZkIkaOM4FSvCVnNPdgTTNDUIwKaJnzujT3bg7XXyy5SdCNX5bB8ldYWeIp
	 tn33zM84aoH4B5RziF6ExPCxQlIJIaMhz2aJeOvN/8AU9v87cgvhnspm8B0V/bwf6r/Fb
	 UQi69Lz7xq3XNxBqBmmQNTSN+klJzo+8VubrCpJsSZeTtDTpC0TeNQntt8PMb+oE3OfgF
	 VDNn4IGzmfqFK2pR8Z16CpKeqvjXQKLghACB+4WET0WVtAK1fo+HNbV1GjAUG+kvuGKgV
	 r5WFCBq9jTkq7eK6Ifzkv/FpqmX8tRX5y3cz3+LBBoyT4d65x7nBVkE4W/LFCGsJCSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BWV1IinUG0DTVwsnY8AqH4VfOLB1w3rql3cUkwGyNXA=;
	b=Vh/adhXOsrxqs0dEcGw43p55GPBx3BOzeAruo1HQLbu1P39QWVKaBQSCcWye6Q16AanK
	 lZVtw7KnEc3IDcUFfnL6yhCp26pUIH2nhRfOskBdfZcIACZfk5Ui4VJ2IlRxAqIqlZD5U
	 DFwy0LCS5xK9hBc5cRxH1XCtyGSlvlpz1OKNML6NNXr2XViYXgWRV3yGhMLnxU/2j8g/8
	 LDBqdM1PRgt5AYhw952S9OUDzNEcd18K43WnB2CMUENY4jWRHVjfm04UGIxmqEtyYWhc6
	 q0tOgDRGeUGkwfL8M33fucl+WE0DmzmYOUNdSupyqLhGlDlw55GtUVFEtYR5ikP11/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pv2ur5Vb;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B4606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 052B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pv2ur5Vb
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a3c08d6928so2543657c88.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546901; x=1794151701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BWV1IinUG0DTVwsnY8AqH4VfOLB1w3rql3cUkwGyNXA=;
        b=Pv2ur5VbbQHTbEUxBye4Ps/lC9cz0ihpSDIvmymLusoZe7zA+A5HL/0yNrAxOiHa88
         dYl1Yor2Q2SsjEWVd5ywSyp7VSOEWwYrHKfZJ2T0vYZXJHWaecQy59bRkYYb5dVp/hQc
         1uS3X4dGkIMKV/D897p6Zs0W4HfMd2r6VxzmOOVUOvoM0O5WpyQFVOXak0Uq0HNE6ER9
         wlHORKwLtmgQpGkwlQ5XG6KIy4S5fG+ZVN0GcRvjQ++imLT5SlrMF8Nl1wNfRQOeTnuu
         tfUu3KuUqAVZpNTyDuhDxSR72qQyaBK0Cu/XLgcxzf5OmRMGZFZP68o/pGuz/IGTJYiH
         +8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546901; x=1794151701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWV1IinUG0DTVwsnY8AqH4VfOLB1w3rql3cUkwGyNXA=;
        b=su3T536dR3gstw0KD7HROuHlAsIxRnWAWWFGVFJAzUDxsq5J6zSe6gE9589+hSg3Jt
         VEKpJC+30UOf/qq/+xuqGi2zAekuCCvQfxOKMq2//LhHOIqdmBBgd+wAD0to/TaVZq/K
         z5+ZC4EVyPQqO0xl0GT0z209xZt569w3pwdEJkDFvdJbTLvq1BJwEgKqF9QJiLDh1fyB
         PV7ymwPGazEVgJKlElMpWmx2EhmxwebYnTVgXkAajwniNJRQMiT4FdwEFKkdgaOfFsMc
         jG0cKuaM2aI3tvbu3elko7BvLbGCYLGcW2rN/jRA22Mp+h++8cMrHysGKRlX+InKlXdj
         GUzw==
X-Forwarded-Encrypted: i=1; AKwUvBwokj01pjFxz87iRhLrwL7u6zXGQ/sSqIOC+2DXX2k0R+h3p5WOxzVqsWkiW0xeLwdflHc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOjeLRiBBR+MkPv44iR7A6zzRmAtwSWGzhDO5bwjo/1E9Wp8+H
	5KP6N24GSeNmQtqFm23pKMy7S1V8UzXCmaXi7vYYcfZpZP8VyZREEWRW
X-Gm-Gg: AYBFou0g7EP2Q+4Uzdu4StzTKb/KivdNzfQxGPReSPRIPIqYDLGPF4Vc0IfvbzFPi3z
	AvenwPev+Co6BSrVZACB/Geu3e69+EgsmJQAYDua19pU8mRlNdmPgoVid4CLycbTzN7p/diKPEo
	MEaB0FquvkG/IGdWkS7K6HiKkD9VcWKo5kJX7LYHnW2xBtwOhniXNlm6F1s+uIAhIBKWRxkApjg
	qRPH8uozXMChEr2/KrERrcDAXH3AaCG2rS08Ifb2ixwZkdxcia6xeaNGLy3ylxDsvGLbvKWths7
	Ml7FTZDXpO5HhuOlSvS4fW9GU5vWrKVDOLKYv07nEbb6GAlHf5bSjYB4bGmpO9RlmvTbU3X9oLJ
	LtRtNUs8Eiqy3AM0U1LVXynFpwIIR8UHmSR2s3eSS3btcfLX4wqShoQejcosrve1AmakZYfkIrd
	wu8/mrSeU5WrL2MlsmCnFvUqcL6IIvQbmaG8TltP+pfvOsn3U7UTfpRweVRyvo4IqL9mGRlUVTM
	VT2zdr86qyzzT2zeUm3XWkChGDOHPvKXV7wCyBaEmNjp9KhURqJ+nBp7ZkzemwkFWVhi9u4nBCT
	PuRj8PYOfHuGKEuiXihryoRREuPQd7RcAQ==
X-Received: by 2002:a05:701b:4248:20b0:191:3c:aae7 with SMTP id a92af1059eb24-1ac5c64cb0emr12048606c88.26.1793546901052;
        Sun, 01 Nov 2026 07:28:21 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:20 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 0/7] KVM: PPC: Misc fixes and nestedv2 vCPU limit fixes
Date: Sun,  1 Nov 2026 20:58:05 +0530
Message-Id: <cover.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

v2 -> v3:
=========
- Fixed logic bug in patch-2 & patch-6.
  (realized after sending + sashiko caught this as well).

RFC -> v2:
=========
- Addressed sashiko review comments
  - added patch-3 to address similar __ffs(0) problem on booke
  - fixed build issues in patch-4
  - added patch-5 to reject vcpu ids beyond the PAPR limit
- Few more patches were added. Few of them were reported by Sashiko and few
  others were caught while doing vcpu create path code walkthrough

Most of these issues were identified while adding kvm powerpc selftests
infrastructure support [1] (which is now merged upstream). Patch-1 and Patch-2
were identified while running the selftests on Qemu+TCG+powernv+BE, while
Patch-4 can also be reproduced on a real pseries LPAR with nestedv2
capabilities.

[1]: https://lore.kernel.org/linuxppc-dev/179211526968.809012.4905747914183363587.b4-ty@b4/
[RFC]: https://lore.kernel.org/linuxppc-dev/cover.1789099725.git.ritesh.list@gmail.com/


Ritesh Harjani (IBM) (7):
  KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
  KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
  KVM: PPC: BookE: Don't call __ffs() on an empty pending_exceptions bitmap
  KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
  KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit
  KVM: PPC: Book3S HV: Fix error handling during vcore create
  KVM: PPC: Book3s: nestedv2: Free the guest state buffers if vcpu create fails

 arch/powerpc/include/asm/kvm_host.h   |  1 +
 arch/powerpc/kvm/book3s.c             |  2 +-
 arch/powerpc/kvm/book3s_hv.c          | 15 ++++++++++-----
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 13 +++++++++++--
 arch/powerpc/kvm/booke.c              |  2 +-
 arch/powerpc/kvm/powerpc.c            |  9 +++++++++
 6 files changed, 33 insertions(+), 9 deletions(-)

--
2.39.5

