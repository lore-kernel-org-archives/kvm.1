Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544433;
	b=ItOHnAne5ibAV86J/mJM+GIMSHdxp1Zxw95A9IcNLvIWrHDO5RmjTdpcuj2il/i74KBa
	 iKi3KBc3sH4HfxtJARz39MLDaNozZdvKbavYPHdhB6OYbfF0Q6ytsu4Py7rzi4DxnRfXz
	 LuKXqy0EEMkzrSlOvCWt2OJtoAmPFBy0nrcKQifjlLFZH1kGRp/vHkF36GSldzaSFmoY+
	 OEeQvoBMjmCRTgvedApm3Xj7uQ0GP8ANPVBBxgufrK4iWCKA4onDad6yGiEU09vN1ayxq
	 dyCAtyNOR91N8wcaRBCbvKcDUEnVrg7Oj+UB+e/QYZrNRjGNnuUk84zCxdO/R1ANolg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
	b=12FCbxB9v9soJ/imHoW+Ek0xMhfCs8LQ1ntN2saADZ55rXEjYm88mvuIhopjYJU8hqvx
	 3U+4gaM546p5ZrvAZA5WJ1tDpayC5dy3PPeRArhEOaP97CA8QUb3WBfkJbM4TAtweinsK
	 Lbe2M9ro0VS75h8zXr78RpbigBhkXhm0ZseDpl6mEnbVkMTSrPY75Qi2TAh+yM3z0AEwh
	 PESnecmJzTmGc8fVeuubLv9kEYzaNmZEYm/1Jhg9HLA0b3F8Oi9OtfXMk1TXmx5ItO8xU
	 usRC+wAo31aQW/MEXXxGv9krnPWnFXoObg1FBvaJ5kmlu/DNZnmvS4lhgP7ksGtQh7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ik/VRERy";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D63606A325
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67D63606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ik/VRERy
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a17a332ecso3643230eec.1
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 06:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544431; x=1794149231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
        b=Ik/VRERyq2Pi8C5N6JrPgt0gUjER35IiFV8EDZLJV0b5clyVOD4bnPTJX+EVUmQsxx
         3ui5NJBOPxnZVjpNemv3TfywG00kn/EGX8Yh54DYpJkm/L+G1Nd1mXJ1tNh20fVf8LcE
         XkywzaV4M1AXV0pTj2dQnmSq0VYdWvaNw53b6jaTtWIZB1gf82zQKodRov9TaVqsMOqe
         ACeojoh1v4K5UlqsG3GNUupePXDWbae0xMAR8+hOYc802n078+Bd2On+o9KhqwWum6al
         2lLFXv6nFZ5ibnnYSuHCNZjMd/V6rcSj0D9oTkqOnM0/oQMFnGXhNVVcZnZiM8dqAPoY
         WXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544431; x=1794149231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
        b=PIhs/jsQ/k6Ye6VJD8fQ0obL2HYQpLi1ZuASQRXxTHfXg+d9EISlAkHoXLOgLrskST
         rzDADzQ2irbrR/7ZnJVnGCH2midYt0BWjtFvTW+GbncYReMuo7IFPeH58e9x2Lk8iZqk
         2WKKzRrSaBz3c2kyBXOh33xjycCqEN/1h9AE4oWXTTZ5c57l1SLVFolIP/f50QG/1WBj
         C+rl+QMYEte6wmreNRYEVgIvHWTlyutLqZav7CiNEJ00/7GuEz5G1MTRHPcrHvcrZorO
         qJ/WtytOO/bpxog/bAEMcS6Uc55+1+q5K4LG7oO+pN6sOXy0IFrHAwNwUnzsb3qoNJOi
         9Emw==
X-Forwarded-Encrypted: i=1; AKwUvBwZAgl26zWGdzbRr6nSB9xqrgw6wE0Mj/HveXKipPxVUF8B7xO1LHbuBve+HUtcGvFgtHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Yv0SBFKPlVGZviHMBbWkg4Tdz9XRboQA0BCxilOawNgkDxQxP
	QJ3+1MWp1FstAblXXVKdjbx6X+jqefwr051rZ1h9wgkJceH9kLeItJ46TGeZ7A==
X-Gm-Gg: AYBFou0PUXK7bbLq66gybJxq+gc6z9HUfix9ZtI71tfbsqYC+AGrWAe+hZlj9LV5giq
	h6cHOAKio5VIwt866DDTWdr0WGy7//ylwLdxFwM8LOGukmftF3TA1JpyjdOB9lIyWMn3vemekMG
	/jE3cHxwHi3uqchoAkb4DPYBje5Pz402aOuVGd6Hjc6Mr2KveKEuR18TEGNHti+UNiTXZXER363
	7tf6I0Y5cWja22Y+9aGjJKqNFKjcryidqkiGfH6TGJZfCKz6DOg1uOXKyJEQJ4XvJYLztEo3jul
	KNynicXsuTLcY9MaV2CoLNsUX83RhsODNI27+UHkvk9GqLj+v7EKHHeQnQqw4GSemjHIenMrGNg
	4gSZ0JJbuxvgE/Uvaqn3w+Cp82D6CHoN1IdDgS5X92A94c0c/SnACPsmN7WF+/VQgOG3D12OL0p
	RyZ+qx6YfYpMqAphoJEponSdhBvTjQkmh+jKUCwNwq15yTog1PeBvF+mdv81Ok5vDRaUOlHJSDI
	iCoykw+KD7wSqI000MwIF0Or0bzvjGLenEmbYKQaSSekqDAELdqHHEnjnia7w8zoVTq47DXVXfm
	zno5I+tf9xyoFOY+YaBrZNEBDJfFqL5Cpg==
X-Received: by 2002:a05:7301:4b0a:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-36a424199eamr11896233eec.23.1793544431471;
        Sun, 01 Nov 2026 06:47:11 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:10 -0800 (PST)
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
Subject: [PATCHv2 5/7] KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit
Date: Sun,  1 Nov 2026 20:16:30 +0530
Message-Id: <183d9a0e755f3735ebd531accb9c193cb40317ce.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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

The previous patch caps KVM_CAP_MAX_VCPU_ID at 2048 on nestedv2 but
nothing actually enforces it. The generic KVM_CREATE_VCPU path only
checks the id against KVM_MAX_VCPU_IDS, which is 8 * NR_CPUS on HV.
That means a VMM that ignores the capability can still pass a larger id.
That id goes all the way down to H_GUEST_CREATE_VCPU, where the L0
rejects it and prints, ...

        KVM: Create Guest vcpu hcall failed, rc=-56

...for every such attempt before failing the ioctl with -EINVAL anyway.

Check the id in kvm_arch_vcpu_precreate() instead so it fails early with
the same -EINVAL. Note that PowerNV and nestedv1 are not affected.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cf620b6534de..5f9cfc34bec2 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -778,6 +778,9 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,

 int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 {
+	if (kvmhv_is_nestedv2() && id >= KVM_MAX_VCPU_IDS_NESTEDv2)
+		return -EINVAL;
+
 	return 0;
 }

--
2.39.5

