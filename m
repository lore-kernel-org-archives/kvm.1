Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174635F19D
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734925; cv=none; b=F6QOR3uvf1njyaNF+l7FXzu9YZn0UxSr8AgB2ucFx5KuqtnBK5+NDifh6LF7LRWBnWMBe9vsgIt9m5VwPh64hw8D2B3G3fqCj6i+UlwJ3C5u5/KihX4vbZAvhoU5ogkJkeAlZJA0sXsCcPs1rHvTudCTSnXk02G8HxDs9KFWecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734925; c=relaxed/simple;
	bh=tBQj3Zs/zFgJuqob5UUxqzp8WSGa3DX0/uF2e5leoMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJMNgBUZtk1f2vZ9rOuHkGY0N3bCckOIp36I47Q4HdkWtLPdDbc+JLNwIYhE3As35ZjLDo0ddXA3QfP/pWipBcmeXMbsnXLeg5jo9cAtoF6UOlPfOuLxCtXVxhQyy+LP/R4kDEIv1QwZqNZLiA5fQpqMYFeNbe0cEQMtcxP6JLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7MLEpKK; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7MLEpKK"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so1547322a91.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787734924; x=1788339724; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DUYw+bKmtZMKiUuqmTKklNQo1kdVyC2ASm9zrjeaODY=;
        b=p7MLEpKKeUZpVNX7qpkrV/b5uhkdrb+LxJ2BcsqAZgv5XKRUJytOE/hhRpzEhSkfzo
         rbkuwA5Bh0etx30osZvXXhx4ckcmZRw8Xk5tCWpQ45XQH5BwGKhl7w7MGtdHSEJf7St8
         CXkC7SWzokp+FAq8NegC46kXUCs0wf+TMD+AxV48l1RskTfCp4Of+thPT+c3qgeKQNe7
         Khp3rYzJWfaDmB7B5dUj9jda2gNyLHcT3fTW3GNWjTcqnKW2pdMPSfBn01Ebzz6osFOc
         8RPGfxCLE6asYrLWQ4OK9ONLX4496OY3/+Ps7MUnA3s138Pja89psKvE+hqsR2a40CjP
         l2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734924; x=1788339724;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DUYw+bKmtZMKiUuqmTKklNQo1kdVyC2ASm9zrjeaODY=;
        b=Seclfw2AD57X5mDDm7GkiczwwPP1l3Oe1OIDRXlsS7vcsKxujnlR0zqq6G2snZLzNo
         VGoK5N4B1YEvEzim5CvAbdufQu7kOU9ni/CmLioArQIHSLXj4S4BxfYy8hxEicxtoe/U
         7EpRx3Aq5/wYHaetD68FSQZE3TnIxhKmrIAEMNtcuxEXxuBYjzvuHdT5wkVRZYHLmvEA
         ddYtAXKoP8HFvQJToZFKO6394N/CDXfTYyTjrIFd+vIZMA+GHxiQNatSV1OdvQGTbEUp
         eGflOYMwXIxnr1S/7OSGcL1TR2//VVj5iamVHLpl6yEhCp3tLjywp60Oj97bBFeSzEQF
         2Khg==
X-Gm-Message-State: AFuF++msHXkqc4swaJ1Ifd+id0ItadrdZVHYAy+k5lGZjx1dx9d+lilQ
	kfUM36OSVpU3VyI6DH164P/zJUue8I0oba/+vIoHbLzhLH7Vm8lKJwEMSzquYKMlXSWVhQTTrmt
	/oGvTJIybVvHNEdx7PWMrsENacg==
X-Received: from plhk3.prod.google.com ([2002:a17:902:d583:b0:2cf:7c8c:cf2c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c83:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-3966d1a48b7mr9860233a91.6.1787734923676;
 Wed, 26 Aug 2026 02:02:03 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:01:46 +0000
In-Reply-To: <20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787734920; l=2054;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=tBQj3Zs/zFgJuqob5UUxqzp8WSGa3DX0/uF2e5leoMQ=; b=nHLIey2i5u9SSFrucSIZdJ1XmfoAN4s5aKHgC3ZELugP1EEPbj+x4Hm6gj03zMVF4F5nca+id
 ZU3e9ubiktdC65mxiZZgRyVvXsoN/yMoCRncYdGQyOWDEy2KAsc3df+
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-no-return-page-v4-1-3bb9c1ddb4e3@google.com>
Subject: [PATCH v4 1/5] KVM: SEV: Treat unassigned RMP entry as benign race on
 PSMASH failure
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Hildenbrand <david@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

When handling an RMP fault, KVM attempts to split a 2MB page via PSMASH.
If PSMASH fails, the only expected return value is FAIL_BADADDR, which does
not distinguish the reason for the bad address. Hence, another RMP entry
lookup is required to determine whether the failure was benign.

Specifically, KVM re-checks the RMP entry to determine if another CPU raced
and already smashed the entry into 4KB pages.

A concurrent operation (such as guest_memfd truncation or hole punching)
can also race and transition the page to shared, removing the page from the
RMP table and causing PSMASH to fail. This can happen even if the page is
still referenced by KVM, because guest_memfd reclaim transitions the RMP
entry to shared when the folio is removed from the page cache.

Treat an unassigned RMP entry as an expected race when re-checking after a
failed PSMASH, and skip logging an error warning.

Fixes: c63cf135cc99 ("KVM: SEV: Add support to handle RMP nested page faults")
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/svm/sev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f412..e198469eb074c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5090,10 +5090,11 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 		/*
 		 * Look it up again. If it's 4K now then the PSMASH may have
 		 * raced with another process and the issue has already resolved
-		 * itself.
+		 * itself. If it's not assigned, then this must have raced with
+		 * another process that made this page shared.
 		 */
 		if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
-		    assigned && rmp_level == PG_LEVEL_4K)
+		    ((assigned && rmp_level == PG_LEVEL_4K) || !assigned))
 			goto out;
 
 		pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",

-- 
2.55.0.887.g758fc8c411-goog

