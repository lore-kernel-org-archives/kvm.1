Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A463B5314
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080243; cv=none; b=U+3MXGT/a58888bqws572rrR4Gv+hMwiph1XDxmswZD97XcCFdI+q83wZ1Z3W9uvhLeKub9wbMsFQc0A53k+fC0tWsbwF1HnBmsRgik+SgL/ytzeRuA70uwFKkxRDXehHqQbX+KBjHI4C8ghwMRoE081cUNbN9E4HCIeQK8NzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080243; c=relaxed/simple;
	bh=R6wl2fGwWtmLnbg8EOaRzIO28mHOcCe3Uhvi8eqzJ6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SyTFr+9yLjOGu9eJJwWq5hdRYOP23C0IcOmB8hKkBBTVBtB4/RWnxMVB23CxuLgS6QblCKYOsHr2zDeDLfYVGtkf0ILz5mQDYkW8KXOgh39dVh9OAuuhns0w0asqiG3f8gVM8vLKJVo/oBYvZ+nQkGgycs667KMd6jCJFTehsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3W8dUiM; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3W8dUiM"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so10937435eec.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080231; x=1792685031; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oj9WfSZX7dlye3OaXiQK3oUYVdZamLk2hD/MZUTO6Zo=;
        b=b3W8dUiMj4wgWG04nTkt7SxeUZzn9AljdG+bKJ+7S5DtZASr19UfFuP/hcXCiQKjtZ
         b0HLABLA+qCB7UojPpWMg78tsFEi7D3B9xfpyEylhjSVQ6kTIL2oS7sSPzhYcyAN3fVV
         Y2oyNf75dkzAlQS6yaqwQSVZeBF8G1E0moR3XIenz6p66KeQvb5pucdBNMmabsxWulEk
         SBUmE2KIdeG10LaNbeebvjFcLuuF7HWO62hNf/9GeY0At39h49xxK6ai9BMtKZS7Rwf4
         YWv1TwVum0WsL6AxnE4l4fQsrpkRGuYxGgsF8CIN/rBMiPYJQaZAt5dojSxBcFptrkgj
         UumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080231; x=1792685031;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oj9WfSZX7dlye3OaXiQK3oUYVdZamLk2hD/MZUTO6Zo=;
        b=pc4+9ep81S6EwmxME+++MLTvhiiQGso6YHFrRZ+QrtYdL8RnAt4QIxMZQBVAICqesR
         WwXjdrtDjcqGHbNtv9eejmwRmrkx+rIBVtbXlD/6eZUtXOq3T7zBL3EnuKBMmQA4vY67
         BXh1k7dryNwppn+16keN5nr7m9hUzsJHALtv2/4Kl551li5D0wTgNc0WHfA0cK0zuFrl
         PiNdm5ubfxN53ec2pYm0wYaN8wusDA78OdvbubjlHoR4kzoxnJoVUL2kuBNdDOSD1mIE
         yWbD/Im2ZZ9HuV80AovBbCNiEK8l5WF4GM3deSiR36YLAa74JPDvtmXOVQLSTQpAmnvX
         C8uQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMQjl9RBSAPuxALeqfOFH4moeM6aSs3/2rT1hq8MU4mvXgwYE/9X+nxaSBncC4dovfx54=@vger.kernel.org
X-Gm-Message-State: AFq9FYJX5LpBag3REd29YZLD5apFcEQ0ID2z7xTsYzFDTolfsxBiIn5E
	fovK3UFNYFO3DYfaVRo51D71oUb7urSVvkyUzo7m74osimZkoU0aV4jXQyFA24UzY7hD+us146t
	upB3aoleW1L04WA==
X-Received: from dlah4.prod.google.com ([2002:a05:701b:2604:b0:17e:b14:46c])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2605:b0:14a:5284:1bf5 with SMTP id a92af1059eb24-16a5adfbe99mr28872690c88.13.1792080231021;
 Thu, 15 Oct 2026 09:03:51 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:43 +0000
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-4-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 3/6] KVM: x86: Prioritize CPUID faulting over CPUID
 VM-exits in nested VMX
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

commit be7fd7c3e8bcfd3a1804567ce5cf9ca3b254c1ba upstream.

Per the Intel SDM, "Certain exceptions have priority over VM exits.  These
include invalid-opcode exceptions, faults based on privilege level, and
general-protection exceptions that are based on checking I/O permission
bits in the task-state segment (TSS)."

Ensure that when L2 executes CPUID at CPL > 0 while L1 has enabled CPUID
faulting, KVM intercepts the exit in L0 and queues #GP rather than
forwarding the CPUID VM-exit to L1.

Empirical testing confirms that this #GP has higher precedence than a CPUID
VM-exit on Granite Rapids (F/M/S 6/0xad/1).

Fixes: db2336a80489 ("KVM: x86: virtualize cpuid faulting")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513224608.1859737-1-jmattson%40google.com?part=3
Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260527174347.2356165-3-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 97ef2ebc2477..3fb9a8205083 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6637,6 +6637,8 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 			nested_evmcs_l2_tlb_flush_enabled(vcpu) &&
 			kvm_hv_is_tlb_flush_hcall(vcpu);
 #endif
+	case EXIT_REASON_CPUID:
+		return !kvm_is_cpuid_allowed(vcpu);
 	default:
 		break;
 	}
-- 
2.56.0.385.gd3acb90ef8-goog

