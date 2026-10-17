Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C347F2D1;
	Sat, 17 Oct 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229436; cv=none; b=odQV61eRQv8TYL+ojdX9HYEt5fwlwLp5+0fimlTkpW0uky28WC7GSjDo1ZaIHIGeShmyl0SLuvekMjQrJF48059a0Fo3UvCDZQdd0NRQm5fLlzBFc6XYLgM+wwH9h8RK0EE3iVa9uaqVWPuLMuolNlLCiVwh1b1UNzZK7SZLZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229436; c=relaxed/simple;
	bh=d1gproy9oF7zXZCfeL17GoDpaBg9gaPpJtC/7WxDTS8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=onE6gLzr2GbMJNe1xrsF6flUyI/epLpR43WsHd3vhDtAnJ5omBYuZyleY6c7TfnEojpSDL8BZY/pfdtwR3JGawKmwQ6fuSjyPptaRoEMdqjBrKFSntZRCcXzBJYb8XAvhEK5DmHf1/mndgZ/isu6j5SUbu4escvj4Wfyc5eNT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=pIRyFbj9; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="pIRyFbj9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4t411huFdYtuNuPySjQ9ZCck/NBFFjumNiKv93w5aN4=; b=pIRyFbj92uEI8RbY+u4MZu+ROa
	TcWyoXSysacKtsbWtbaexovJPogFjCZEgdw8KzSDFfFkYx9OGZvcJ7N0B/N/Jt5XZW0k/rxDCtLb8
	dWG1f0Y3a9vLIltaSTjQrq24qcPW3GT+o1kbjywFQW7DeEUXJPg/40ZcdaIPYyKAcSfS2oG+4Ojmy
	Q2GImb1NEE9gRUfUrUKyiy2u+QL8HUU+KVxGoJPr8Lgn++gg/F+fWfV3g/GWrGx1tx7a9R9w5DmTF
	uSqj115cw2c6UeDtjICa/dI/5UaTytrGl1iDtg40jiubAu6/B9BGxfbNsQgmh2P7ZsrphbkTXss77
	A++L2ueA==;
Received: from mailer.gwdg.de ([134.76.10.26]:55350)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kL-00BAXo-2a;
	Sat, 17 Oct 2026 11:30:33 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kL-000VYi-1B;
	Sat, 17 Oct 2026 11:30:33 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 11:30:32 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [BUG] KVM: x86: Hyper-V VP-assist page reuses the KVM PV-EOI gfn_to_hva_cache, so enabling both WARNs and fails KVM_RUN
Date: Sat, 17 Oct 2026 11:30:16 +0200
Message-ID: <20261017093016.32348-7-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-07.um.gwdg.de (10.108.142.66) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Hi,

Reporting a guest self-DoS (correctness/robustness; not memory-safety, not
guest->host).

The Hyper-V VP-assist page and KVM's PV-EOI feature share a single
gfn_to_hva_cache, vcpu->arch.pv_eoi.data:

 - Writing HV_X64_MSR_VP_ASSIST_PAGE arms the cache for the VP-assist page via
   kvm_lapic_set_pv_eoi(vcpu, gfn_to_gpa(gfn) | KVM_MSR_ENABLED,
   sizeof(struct hv_vp_assist_page))   /* hyperv.c ~1600 */
 - kvm_hv_get_assist_page() then reads it back with that same cache and the
   VP-assist length:
   kvm_read_guest_cached(kvm, &vcpu->arch.pv_eoi.data,
                         &hv_vcpu->vp_assist_page,
                         sizeof(struct hv_vp_assist_page))  /* hyperv.c ~952 */

pv_eoi.data is the one gfn_to_hva_cache shared between the two features. A guest
that has VP-assist enabled and then writes MSR_KVM_PV_EOI_EN (a different GPA,
len 1) re-initializes pv_eoi.data for the 1-byte PV-EOI object while VP-assist
stays enabled. The next kvm_hv_get_assist_page() then does a cached read of
sizeof(struct hv_vp_assist_page) against a cache set up for len 1 -> the
length/GPA mismatch trips the cache and KVM fails the read, surfacing as a WARN
and a failed KVM_RUN for a guest that did nothing architecturally illegal (the
two features are independent and both legitimately enableable).

Impact / class
--------------
Guest self-DoS (the guest breaks its own vCPU); low severity, no host memory
safety or cross-VM effect. Reported because "enable two unrelated, individually
valid features -> WARN + failed KVM_RUN" is a robustness bug.

Suggested direction
-------------------
Give the Hyper-V VP-assist page its own gfn_to_hva_cache instead of borrowing
vcpu->arch.pv_eoi.data, so the two features cannot clobber each other's cache.
Happy to send a patch once you confirm that's the preferred fix.

Read-confirmed against kvm-x86/next (tip of 2026-10-13); present in mainline
v7.3-rc6.

Thanks,
Amirmohammad
