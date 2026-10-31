Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793437533;
	b=qJP202WsDxsH/Cb9SYpNDXeEBMsdXUjn/ori4R0bg5eSKot8qUtHYSPba7BE3fuOifec
	 unGcQmWdFggv8FZTF4DS4E1KbrXmVSh8fH2QmmRemPrqCKfAu4b3BPAPfCo/78edVfn34
	 Y3ieQwjlaNW2I+JDiFwZ/ZIq5iH4mWcrrZ2igyXLy8+D5MFdr5CeqcHgwldU0fGzM9BwS
	 nUwnI5YKlFATSXQDHD1q99Ls88aq3hybv1SL15GMaF3A5LGvkAfenA7SEe+ZUK98I/tMa
	 EgkvJy0s0/0H0+4mHUJSP8imvvb6/W+CVvVtypseC4CzS2AODMHhkstgZ+LhRbflqQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793437533;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=cGV63zOdaaMx02zc2ytufIk7kkO0ZAWOzzUSuNWiP6I=;
	b=ov/K4MVEiS0bQfNgyeQY1ewbJV14gh/FNMt7or3M4y4P8xSPvPzwssdTUfAEIaD8/mxr
	 O5NJWydF2gXX4N3NU1iiLkr0GuGmJXT5X3yq9xKa85BCvnLb2xaLXvUxxKVlci45qGjJg
	 FojbiMdedSS2fGertcRG5f8O6tUKZbL1IMpmQ3KTIk9licb6GvojU9I2hw5QZ1Z0gRzhe
	 eSuZVIEm6pC4Ja+Bpfx0TjOT/yEd/53JOO3DtE2mKyQTVvORnuis75q5PbBxIDmy2kG1R
	 qJ901jZVY5lxDsDLEHnu1PVNYiG3/tHr6aCI6bWIdP/VN+Rs5c4yBXKTf9voXBXszaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=cT6XAza7;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EB8606A31A;
	Sat, 31 Oct 2026 09:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0EB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=cT6XAza7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cGV63zOdaaMx02zc2ytufIk7kkO0ZAWOzzUSuNWiP6I=; b=cT6XAza79BTnk7W7dpfcZFJ2TR
	S2sq3hjHGPm3McvQCYexhBSn4ynCR+yYOnQ4miDP1mYnPhsAZI4sHiJ/YWgEf37awJO+aWCdd/igE
	yK2UPV4EbokW0OmporduRyAKEDoDAueFE4A0waOVdT55HhD7Nd2EVb0sxdyJ6z+h351lhkHsHBpa3
	ugYOS5UtMbx5ZKP8JWsrNoAaDMJkRcIygMu5BpGBGKYgsapVdCANoPMa00RBlH81Pz8b8UPd2M2Tk
	gh2rkpGotZGAuENFW52tsiYWl5lPHTxLWGd78osz8XWxFUFBMXc7GEN3S8vgYV1DSj7XYZ/6ZZOjq
	hGGpX80A==;
Received: from mailer.gwdg.de ([134.76.10.26]:34293)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN51k-001Wrx-2B;
	Sat, 31 Oct 2026 10:05:28 +0100
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xN51k-000J3m-0p;
	Sat, 31 Oct 2026 10:05:28 +0100
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 31 Oct
 2026 10:05:27 +0100
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <dwmw2@infradead.org>
CC: <w@1wt.eu>, <paul@xen.org>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amirmohammad.eftekhar@cispa.de>,
	<amirmohammadeftekhar@gmail.com>
Subject: Re: [BUG] KVM: x86/xen: gfn_to_pfn_cache left active after mmu_notifier release leads to a host use-after-free write
Date: Sat, 31 Oct 2026 10:05:19 +0100
Message-ID: <20261031090519.65206-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <atolq8545YGo4iKx@google.com>
References: <atolq8545YGo4iKx@google.com>
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
X-ClientProxiedBy: MBX19-SUB-07.um.gwdg.de (10.108.142.72) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

On Thu, Oct 22, 2026, Sean Christopherson wrote:
> Anyone object to taking this on-list?

No objection, please do, and thanks for picking it up.

> I'm pretty sure this should go inside kvm_flush_shadow_all() [...]
> The other wrinkle is that super strictly speaking the invalidation needs to
> happen before kvm_arch_guest_memory_reclaimed().

Agreed on both, and the comment can go.

Putting it in kvm_flush_shadow_all() is also right for a reason beyond the
mmu_notifier point: the stale cache at release is not Xen-specific. The KVM
pvclock cache (vcpu->arch.pv_time, arch/x86/kvm/x86.c) is left active and valid
across release in exactly the same way. It just is not a use-after-free write
today, because once the owning task is gone nothing writes it asynchronously,
whereas the Xen event-channel hrtimer does. So the Xen timer is the only
reachable writer at the moment, but the dangling-cache condition is generic,
and invalidating in kvm_flush_shadow_all() covers both.

> Rather than pass literal numbers, what if (over a few patches) we massage
> gfn_to_pfn_cache_invalidate_start() to take a range pointer [...]

and David wrote:
> I think I'd be slightly more inclined just to add a parallel
> gfn_to_pfn_cache_invalidate_all() which can be a whole lot *simpler*
> than the existing range-based one [...]

Either shape is fine by me. The one practical difference is the backport: the
standalone gfn_to_pfn_cache_invalidate_all() is a small self-contained change
that is easy to send to stable, while the range-pointer rework is nicer
long-term but more churn to carry back. I am happy to follow whichever you two
prefer.

I can turn this into a proper series and add the reproducer as a KVM selftest
(the UAF reproduces under KASAN through the Xen timer, write into the freed
shinfo page), or just test your version if you would rather carry it. Let me
know which you prefer.

Dropping stable@ and security@ from Cc, per Willy.

Thanks,
Amirmohammad
