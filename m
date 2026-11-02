Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661279;
	b=ur5EtNkPDwYynYvGQrEQYIDNEYlgr+n8AkmfRnsDFfpCWcjfZiweJRMiKEUpcJG/vQlU
	 aO4IzFJjkSL+CHKA+cSdw+5SR2P2Qi7y4rsSP18COcGVMPY/Q/fegH8EoobuO2K0NmBxo
	 5vA69PEH2nYKutKUj9mKO8ckmQ5YZ7fMAiWcOOXkV1WuN6P0DFSdot6cWsNhOEFs6BBUu
	 i9OBScnzTPI2ecxCvc/dt7y101wbkUtUzwF8m7oB3kwAQ7eEXvsE0o3JgSXqcGViLY3T/
	 CiELY2IR4UPjfjApT5EDJwet2g7QcD6tKWcHmLdnSUv54nJad21IPS82K7D+rZSK7pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661279;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Byfb0b0PdWFP3RLpP28xfV49PVRbqVGKEwUtSkk7aJw=;
	b=MITl41Rqq86+ag+aKfXeg3xptSuXYUbjXpO2OGIUB+xA3n/59wlFsLBEdPRfbuoIYX3I
	 TkLcPWwbh3ukuTDLWpjx9iW4QNkiSgAWN3SI/G+2bKDwO9UqFT7x2iqHAplzqHSIp8c0j
	 CVk9Vj+rXbV8K/YGElmXKT00dY8rRzlAUeMe4QHzMc7LS0pCUf07ckZLFGfJatmxsXQsI
	 wXz8QNkfUlsCzHkUq01cxpxQiZi7znSu5jMDMDwHeZvBwcEmITAdHY5lgmnubgPhpCb4D
	 yV+MT2CPEr2D2Wo77+p3EpPafRoChRwLtWaiYYc0YYAWG+DNe/AePh2vLuLB0fG/DDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bggx5xRm;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49808606D836
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49808606D836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bggx5xRm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793661278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Byfb0b0PdWFP3RLpP28xfV49PVRbqVGKEwUtSkk7aJw=;
	b=bggx5xRmQP/Ui+iPaAkcbRWgQj5NrEjqPsnVgTvrCPJNM/ZnTuksL9HgZUx2BgK6e47zcm
	EhW6eOnRQj37WeohBNWiUv/tnpp0Bm8b0hHIAUkc2VnwnKNrwv3Qmog5Ra29v0a5JwuhId
	EA2DqAB8LP4LfF4djd7BrBo5mkT4Bn4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-5t5Pp2G_OCOQpCcFjnSNpA-1; Mon,
 02 Nov 2026 18:14:35 -0500
X-MC-Unique: 5t5Pp2G_OCOQpCcFjnSNpA-1
X-Mimecast-MFC-AGG-ID: 5t5Pp2G_OCOQpCcFjnSNpA_1793661274
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE9841800596;
	Mon,  2 Nov 2026 23:14:33 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B61BE7E0;
	Mon,  2 Nov 2026 23:14:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Stefan Teodorescu <fane@google.com>
Subject: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once when unwinding failed VM-Entry
Date: Mon,  2 Nov 2026 18:14:25 -0500
Message-ID: <20261102231428.13523-5-pbonzini@redhat.com>
In-Reply-To: <20261102231428.13523-1-pbonzini@redhat.com>
References: <20261102231428.13523-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Sean Christopherson <seanjc@google.com>

Add a missing "break" in the inner for-loop of the open coded mess that
unwinds MSRs back to the pre-VM-Enter state when VMLAUNCH/VMRESUME VM-Fails
due to a consistency check that is caught by hardware but missed by KVM.
I.e. move on to the next MSR in the VM-Entry load list after performing a
write using a value found in the VM-Exit load list.  Processing *every*
matching entry in the VM-Exit load list makes the processing quadratic,
which is problematic if the load lists are full of MSRs that are expensive
to emulate.  E.g. writing APIC_BASE triggers kvm_recalculate_apic_map() and
a whole pile of unnecessary work.

Functionally, arbitrarily restoring the value of the first matching entry
is "fine", because none of this is architecturally correct: the load lists
are never supposed to have been used in the first place.  In practice, it's
likely a moot point as no well-behaved VMM will have multiple, diverging
entries in the load lists.

Fixes: bd18bffca353 ("KVM: nVMX: restore host state in nested_vmx_vmexit for VMFail")
Cc: stable@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>
Reported-by: Stefan Teodorescu <fane@google.com>
Suggested-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20261027185917.1478906-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..f0d75f5a968c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5057,6 +5057,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 					__func__, j, h.index, h.value);
 				goto vmabort;
 			}
+			break;
 		}
 	}
 
-- 
2.52.0


