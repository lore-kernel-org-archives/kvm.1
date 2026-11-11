Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411445;
	b=RXp+7FmRuxiKewbmscjPCeh1EhLF6Qe3q+ELbyhmWCb3ewBOMmwVD/ApXObCyMgqUx6e
	 39s+zGA3k8FXvp5GuZodxcuAd3v65nvIDFL/WvsLSF/d8YqN3nT9rKlhwCOazRlkntrN+
	 v4lsOAMoLpChQtltjS928F1MWYuhXr7b2ieOvB3LkXb0K88+qRZoRs31RepfN0uVf+4/F
	 XuYjon6HLGlqLLtMvIBufM3xKFDtMDCUJ13/yFwlWHWXS41xoalQ/KW7AoYkRDS7PqA7+
	 e32vrPVFx8PPKFaJOAvpJqJrNlWlxEEaVSXeTx2zLjrQWNv5GapC8lvoFdUWXEkpK0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2aEf9Tb60R37agIedsR2WCZzM4Iq3CiYrJRYQp6SlaU=;
	b=Mw3wwor7qnYTkCS16pKoKwRl1nwQZXxHHCM1rgPoZ39nj1n6aWwZE4Plp1ZoSmMyVzgq
	 9Jz03F38cUJEZvOsbw+knAVoOIASRkAETHdwqkKBLAiv+VtmeBJ/aYGKMcIJOhflG+/CA
	 Q4GqvEzqL9x0ryGNyNuLT0+D/ilkEidQ0bdMT5tKvlb+VtF4xvBwGUQD2jDQc1ctcCSOR
	 H8Rn0nnoRDouWNDtgycvyP7dJ2uFPO8sfXXryILGZZfyrmDn5lqMyc+PFUMCy2KD2Oac+
	 tm8srcuiEGasRTLaN7s6LaureyHU/4rKLw/G1STZ/yGnCSGVsFFCX7BUrn0CrArgtAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DaXGrjAK;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8C606A89A
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 15:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B8C606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DaXGrjAK
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2edd25534afso11100335ad.2
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 07:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794411444; x=1795016244; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aEf9Tb60R37agIedsR2WCZzM4Iq3CiYrJRYQp6SlaU=;
        b=DaXGrjAKFyJ4fHC4PZbapTCZMK1TzXl824ywIxfrL35hqFBguQhN0MtQ+esi1vyoS/
         bqpwVmDBOtVoyUZN9UAJi4NTRo/H9EMZ/VE6rMahAB8HGsAuIxujhwUbOoxzVZHKeGf2
         sWSVKpGIEti7wcL8BkBTZnSI+xD7t0lW0gnEgX+OzJHWEjQf+NfAvxXDasoUz6BDNiuO
         8L5ZTjNhwT9sRViEIhb5gNYz6dueMz4z2FDafS8FgfbaI/THObYKb83jBELF7OSrKiE8
         Va2/EJ7aKK0ZWTGeogXwZ+JPdXttw5y6sMCV346sn8iqi4Faof1118wojP/p0Ve0JqAj
         JC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411444; x=1795016244;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2aEf9Tb60R37agIedsR2WCZzM4Iq3CiYrJRYQp6SlaU=;
        b=Uh1gMdVUg4xrkFMPnAi5E7lhIKrkibSnMwFpcrGZUcpYkh+aBctzTp5cppCuLHq3Qh
         HNyYJMiJ/+xaJcUWPUy16tzgjqmb2bWmYDR2KOXPsY7I6yh2Tqzyqd3CUyvuis1N6Zcj
         kbH8NBlyzXMTZ47grMiNwtVSlGBPrZDoW3VSidGoRABmxn+UjR+bPzuouM5XWrU0xd00
         5vt4lAQwbEWYnf6Mmn466tsq6bqbCbHAH5FWr9xIy74zsAD+N2kuHBSplHaCrjcPhAPd
         z5BPPPRA+yYRyhpBJYi38sJmjnX96ZaxeRjHbVkxkke69b4zdrWqcdkvaMHMuGphs+i3
         Gtjw==
X-Forwarded-Encrypted: i=1; AL+hErFFvDrG/Y8N2H4f6kioWH9/7NFjNjfHzQdUEV99ZKFdGxJ9I59ZY1F2FdkSYJ73QFWJZwM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6HoZxo4A+AYA6DPzKQyjgRzp8v9w+tnYtmWekHr+l4HbSilcH
	whu5u2WXSlLgUbPnKm5BjAZiM6ZaED4jhDnMtBUqLfq0io9uNXW0SPw4TFpuOy78NflTLnlQlrY
	4bLMHZQ==
X-Received: from plbmg12.prod.google.com ([2002:a17:903:348c:b0:2ed:5534:d103])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0e:b0:2ed:2e3f:20db
 with SMTP id d9443c01a7336-2edd7a98882mr28811385ad.46.1794411443626; Wed, 11
 Nov 2026 07:37:23 -0800 (PST)
Date: Wed, 11 Nov 2026 07:37:22 -0800
In-Reply-To: <970e231b-c3ce-4159-ab27-ac371426500c@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-14-zide.chen@intel.com>
 <au491iiV7koeP0t6@google.com> <f20b59bb-a3c6-4129-ba61-5cec4d975601@intel.com>
 <f12bcb27-9c17-4b8c-b48c-c36a17e70ab6@linux.intel.com> <5f129d63-10c6-414b-86a9-a604e42038ce@intel.com>
 <51089074-1be0-47e3-8d53-732ca33f29a2@intel.com> <fceb4f61-621a-4d62-a648-a1cdd0de1671@linux.intel.com>
 <970e231b-c3ce-4159-ab27-ac371426500c@intel.com>
Message-ID: <avSLss14zigMfUww@seanjc-mac.roam.internal>
Subject: Re: [PATCH v3 13/18] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Yosry Ahmed <yosry@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 10, 2026, Zide Chen wrote:
> >>> KVM's principle of "not policing guest CPUID" means KVM allows userspace
> >>> to configure an arbitrary guest CPUID without rejecting the ioctl or
> >>> mutating the vCPUID entries.
> >>>
> >>> However, KVM's internal vCPU state (pmu->version) tracks the "effective
> >>> PMU version" that KVM can actually virtualize.
> >>>
> >>> This distinction is documented in commit 4f1bd6b16074 ("KVM: selftests:
> >>> Test Intel PMU architectural events on gp counters"):
> >>>
> >>> "KVM only officially supports up to version 2, but the behavior of the
> >>> counters is backwards compatible, i.e. KVM shouldn't do something
> >>> completely different for a higher, architecturally-defined vPMU version.
> >>> Verify KVM behavior against the effective vPMU version, e.g. dvertising
> >>> vPMU 5 when KVM only supports vPMU 2 shouldn't magically unlock vPMU 5
> >>> features."
> >>>
> >>> pmu_counters_test itself explicitly mentions this rule:
> >>>
> >>> /*
> >>>  * Return the effective PMU version, i.e. the minimum between what KVM
> >>>  * supports and what is enumerated to the guest.  The host deliberately
> >>>  * advertises a PMU version to the guest beyond what is actually
> >>>  * supported by KVM to verify KVM doesn't freak out and do something
> >>>  * bizarre with an architecturally valid, but unsupported, version.
> >>>  */

...

> >>> Without a PMU version cap, guest resource validation could become
> >>> increasingly complicated as more advanced PMU features are supported, as
> >>> KVM would need to allow the guest to access PMU resources only when it
> >>> satisfies both the vPMU version and the KVM capability.
> >> The above sounds reasonable at first glance, but in practice it is
> >> problematic because it arbitrarily masks out features that can be 100%
> >> emulated in software even when there is zero host hardware dependency:
> >>
> >> - Features that can be emulated entirely in software (e.g. there is no
> >> problem emulating the PerfMon v5 AnyThread deprecation, or emulating
> >> MSRs like GLOBAL_STATUS_SET or GLOBAL_INUSE on a v2/v3 host). Clamping
> >> the version unnecessarily prevents the guest from using features that
> >> correspond to its configured PMU version.

Just because we *can* do something in KVM doesn't mean we *should* do that thing
in KVM.    

> >> - Features that actually need host hardware support need to be checked
> >> against both guest and host PMU capabilities.
> >>
> >> I'd propose something like this instead, leaving pmu->version unclamped:

Why?  What real world use case is there for KVM actively supporting a PMU version
"greater" than the underlying hardware?  E.g. emulating AnyThread deprecation is
(presumably) easy, emulating *all* of v5 on a v3 host, not so much...
