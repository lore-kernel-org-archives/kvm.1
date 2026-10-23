Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746205;
	b=WWusbrGJJkriLJSPeIHoOnvHF8aNRV8kKX7ZuIhVOilSwnAH+egAVEi8p94EvelrSmdg
	 OZPJIMhdIMxkaU516qVQQF689CdlUhtEJNwukuClFVgrr3cf6tHz91rGDD+WxCx7IQjLx
	 RxcTtFrRa8T+JzJ6rx/OK3uQAhEBvL2clvDqX0PkTUedWg2gdLXVHV5ZtwmiFW24eK889
	 aKs0KnmadEbk999WG5xWltEKQDgc6YSbsfLfKb6knTDqutmQJOcRSTXYuE+NkgKGsKdkM
	 il1Eg3hFSueaIvfpt7Yn+0F0k9MpXIlvNwA/Iaw+0jtVaEOjYKwwgdntMtAWiF3Do5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746205;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=+TPZCqvEzY45esRVQeY5p3s4Xp+9LPXNAGtYJSVwFMo=;
	b=kyRNyQFURNt47BgVRLlZzBWxvZOZlK+3vOMeb6B11+m/a7gP+RIqeMNGzki0jI1X9FJI
	 Qn2llrpA9gUMx3BfiRS1LdhgKQXFkqD+g2KH3GrgUje4AXoGC9dtPScyQGMZzmSVU6jna
	 KyR/udBpKyEixxNH3r8cfIs3/O9LZfxtrBbV2Umx9qdz+vbh+o+zADGjZ/DAkbMaoetSI
	 yRRcTJa7mi+xqK6bu5iRQy6gRTOIB2Ja0P6NB3FwIocPanMvHDkUljOMbNiiyZJnOgyLI
	 4xVo+eggUriHjfJO6ongC3iNXQ1VIfvSzFbDnhv981Aap5Mu8HFEOy1gqehM6nfMrXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=ZcDP1FMl;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B1606A321;
	Fri, 23 Oct 2026 09:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B64B1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=ZcDP1FMl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+TPZCqvEzY45esRVQeY5p3s4Xp+9LPXNAGtYJSVwFMo=; b=ZcDP1FMlhMW7kAS20/0s5Xk2yr
	16Uhd83CLkS63KYMQGl3rZMw+EXTqMWf3TSVFxDpDD6Ws6RzQ7whV5HCKGHo1GVTERmgpv+osk/fg
	//JZxORp1pBhSJNyEbrVzeoW8DNtjn3ke4dVvyAs3/D92Sjw5L52UwlyW4iZfBWSHe8K+zFUz/7c7
	QwSqePMBpG8Q6rYm+cN/WVtbTWlsPtQwMKF7d4wfLK1Hv6Z1SexrtratqeNfsYtynZuAXvvqoeMv8
	nshHT0PQ/Aw3bvDO9xeY9gfEVKc9UuLv+s6zF9Ou9Pe9LGuCjzlsKinzMPdcZczf7WAuQopBi6db5
	AYPnioyg==;
Received: from mailer.gwdg.de ([134.76.10.26]:33723)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKBBK-00ETwh-0a;
	Fri, 23 Oct 2026 11:03:21 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKBBJ-00019z-2R;
	Fri, 23 Oct 2026 11:03:21 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 11:03:21 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammad.eftekhar@cispa.de>
Subject: Re: [PATCH] KVM: nVMX: Restore L2's DEBUGCTL/BNDCFGS/CET from vmcs12 on RSM and nested state restore
Date: Fri, 23 Oct 2026 11:03:13 +0200
Message-ID: <20261023090313.9524-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022223820.8279-1-amirmohammad.eftekhar@cispa.de>
References: <20261022223820.8279-1-amirmohammad.eftekhar@cispa.de>
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
Content-Type: text/plain
X-ClientProxiedBy: mbx19-fmz-01.um.gwdg.de (10.108.142.52) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

The automated Sashiko review of this patch is right, please drop it.

I missed that the pre_vmenter_* snapshot is taken from the loaded VMCS on
purpose. The comment on struct nested_vmx says as much: on
KVM_SET_NESTED_STATE the snapshot ends up holding L2's value because
userspace restores the MSRs into vmcs01 before it restores nested state.
Reading from vmcs12 on that path discards those restored values, so the
patch breaks restore rather than helping it. My changelog had this
backwards.

The other points hold up too:

  - On RSM and on restore nested_run_pending is 0, so prepare_vmcs02()
    hands pre_vmenter_debugctl to vmx_guest_debugctl_write() unmasked.
    vmcs12->guest_ia32_debugctl is not validated when
    VM_ENTRY_LOAD_DEBUG_CONTROLS is clear, so with VMWRITE + SMI + RSM a
    guest can trip WARN_ON_ONCE(val & VMX_HOST_OWNED_DEBUGCTL_BITS) and
    get host-owned bits written into vmcs02.

  - vmcs12->guest_ia32_debugctl and guest_bndcfgs are not reliably L2's
    live values anyway. sync_vmcs02_to_vmcs12() deliberately does not
    save them, and vmx_set_msr() only updates them under the matching
    save/load controls, so sourcing them from vmcs12 can regress the
    plain inherit case.

The only gap I still see is narrower: on RSM into L2 with
VM_ENTRY_LOAD_CET_STATE clear, the CET snapshot comes from vmcs01 (L1's
state) while L2's pre-SMI CET was saved into vmcs12. That looks like the
SMI+RSM corruption the TODO near vmx_enter_smm() already flags, and if it
is worth fixing it needs a validated, RSM-only change, not this blanket
one.

Thanks,
Amirmohammad
