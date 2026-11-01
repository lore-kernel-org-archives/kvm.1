Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544409;
	b=JzD0k7WDkd5t/VYoFGSjJzaWviM67PFObZTvGel86KQqZsVfX2z4vDUQLm2Kah+9YHO+
	 vvW9w95FV1b41Lus5mnZ74+pAs1NhjTkr60y8HRX8tY7WyuikT+Yp0EKzl/wIW+KvYxAH
	 Qztvr2uwOdYVGJVfEUMJGTCSAMYEPIVixfYXucYvFsSy99hOnTtv2XfZtjZ6YsGkGnNrB
	 oo6U5PstqWGB0UKS9bkCryXbTqluT3h/MSKrVQKnJdPz7pzt61B8MksbUnSWfpj8L/9/0
	 nhLOUlXFEDMCg/mRkvdXYjgDGMwAVH52vl+/f9DntOuc+A+UuOjz4oJhgn+sobDrOMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wi5Uu//3wa8/Ft7s/aMc5zpRyu0NlDyq71TEbyp4LVU=;
	b=WmDFG8DVhMsoL6dUwR2i2hg+saBzeAO/EvNUt5ppMNlH2sywUPanZoK091hxXKl88t7Q
	 SfR0qRSUshAv4yHvfvHSSFRqFa8rbWTDeqhPtJzOBNeoM5WKavByHhVFhFdHcSYCWHBjy
	 guERVCOsoRXnQImvzyLJPU2ju00v2Mj25Yqne7PgNCfmMLpixO8B7DUMx5xnAGP9MlbXK
	 HTL34aKxPvrymNxXhjo5sjOVxbDT/MYXCm+og8lYL138+LRMN4kIg5gu4QaIirFCaXk8+
	 NJ3NDHIYJlizrXCPxpAzpaEe48qTktyQq/v2qx+d9+2OaKvuQmd8ZSx+F1hb+s2M0xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZeiaaBe1;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E878606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E878606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZeiaaBe1
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35829219da8so3848082eec.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544407; x=1794149207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wi5Uu//3wa8/Ft7s/aMc5zpRyu0NlDyq71TEbyp4LVU=;
        b=ZeiaaBe1IVMNoudVGvUleL93XFdETCYM104SUBSv+F4HltfVEUzJAjSlK0rRa0Hnd9
         bP+LCvOVh1K8FhEVQdEyCPM9rXZ9ZqZdY6z7QsnTzdGysrxQkNOT+d9cmrW+KVpEaXgj
         qFK7KD506BYtg9a2XFkfhj+xVJ3aLwgrRxhT0iF7A8/DjTCC7yK9MatlxSyV95otVUBC
         PoHqGrQ3OvvL2KySxLQIKvOc4fJMqVQvvNatUg5Tgkm4bQj4LFUdVhWkPPDglI1SkBbw
         PZZfAlt3qX7psTKth3WZSYS3v8vq3AH8bkvozeWefsmjtpI89lNoB1i7FnjvtMVKmnam
         TjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544407; x=1794149207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wi5Uu//3wa8/Ft7s/aMc5zpRyu0NlDyq71TEbyp4LVU=;
        b=rQI4/potyQIjyiLRab7IUHzny6Bj2nsBajG30G8P2iEIJdtdMTTi9mIrJz/Gxh1Nyl
         J4OVMuBq+F4ITnJOpHMgasy9Ti2EZs05ni4gy5b9AkyzoCVy1vQFeBhpS/OmTNUYlgWB
         tdmsVyCUXCI0ItzfM/wjnlShGJpDpp8N3v3kpyusMelOsUKvpJxcDL9WrN1LXBn9Pc+0
         AgNYbOfAAzkHETiv3v6WSkKRvLM/nOiuOhrAgNLo12Y5fp1ID+2lygImv5H9srFQQrGx
         GsYZVrLt5E/wAf0qv0fECgEMuHT1JqCXm3JK8pnMnOdbnSds1CVm2a4Mv8jz5HhQPYm2
         awXw==
X-Forwarded-Encrypted: i=1; AKwUvBwKrXD2FG6cXJeFQIhzydZD526IzQvY5/m2sHmi3e24agZR7jyJr+D8Yjddmm/qT9OCmcI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MBzTo1ex0KyCvgPiqemKrNARBr/8rEVtTi8ZE1w4e5J9kx/VZ
	RQ6hhhCxdgCYXNTvCiJoYCsnqYOU7tV7HgKitMPb85KzRTQ5fnICUS6/
X-Gm-Gg: AYBFou1kN/M5w4SXPomAMp/EFpbt2oUq1DqB3C6e2UbV3EJvgAvSs/DMOfIsh4mjxxF
	iX71kwgFL7J5Xua/wteEIj4RdXvDjKtDKHAPDkI9hSe8ETQ0RlGZKsCeF8eWyphN2uO8rCD5HvV
	E9S3/zzmumRIvP5tH9IYOrw+sM4LxCDqTOLW/p6mLgWG5HQvwbc8nqLQtyQLl1Z0PDN/PU7NZIR
	WZ5TcPvPrXi4avwoc+daU7xKx5HiSzDc0Q5tZFgO2MviMeJTNIjFf5g7P7YcARYqRuIv2awfIy+
	54PS6TdqWGw9kt4R2JyOPF3tUHEgp9putDsH6RsJExjzXxDwMVSj9herPnFG+6SJNdeqZPsqTOV
	Wn6aNSRc0+IRPqHsxVj1gJOOqXASAbYflGMYlECuYe7YHJSF3lsbi+NzzEh932L0lRgPV98Mv7a
	MO7DnXR+A9PYVerj6tlPRZoQNprRUTaYtqDIcFH8FXW/3+EP8CZ9T3x2NdclSgknw2W33q9BkF6
	BAURHX+fyJryGZRshc/BqTA81yhzFiQUIKwJ7St5w0gGVnMbOsCgTaTRKOuGHiwqrJjAEhRFq7s
	fBpRaejmy0rUpOicLFwUM7INJatbKOLi7g==
X-Received: by 2002:a05:7300:3b05:b0:369:e8a8:b9cf with SMTP id 5a478bee46e88-36a3002ea8cmr21134686eec.11.1793544407273;
        Sun, 01 Nov 2026 06:46:47 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:46:46 -0800 (PST)
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
Subject: [PATCHv2 0/7] KVM: PPC: Misc fixes and nestedv2 vCPU limit fixes
Date: Sun,  1 Nov 2026 20:16:25 +0530
Message-Id: <cover.1793543627.git.ritesh.list@gmail.com>
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

