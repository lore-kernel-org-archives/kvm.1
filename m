Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107772;
	b=5MSanMtdm51oDAmThmi9MwSQoo3BAMyxioQ8fXMjvY/LPwDUgk/BWZnhAaJkmOROv75q
	 GdZPYQRH0MzldpFOIJVCJ/SY6eBPDV1GbIBHyj87zcuIi0JTL7ePwKOIeoOONnMBYblCa
	 Wqjy/HFdzS6OtjYxNiBnwWsbwB5QEUPtSzucdNlxRoNRT8T2rLBHACULJ3rSTgdUXQcFR
	 JLpLgk5ByNfqsscTDdp2HIM4LfUoT1M7yegu1qw+K9OA5FugZhcnmjZ5Obs3jobYgAHSd
	 f3W3vLYEtqxMseYbMknyrRU9zT380q+QgIivrdv16p99bjn096Pbz/JNSOiwq4k0Zzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107772;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=tuaICnb7sTsU3uMtAf1IdzJMLdxwJHMKKBVbfNsG8e0=;
	b=Jza0kfS+hJsTeHANRFw5EiaBdk6ZjY1nfOoOtoHEJ+XFNu3Y1iPQhDbKY6DhtDashlBA
	 9R0/jciRYBvF8KIU5gXRp+o+DPpamfDK6fETxd+x1j1vmC9wbksF9L+CU4isO5drBZ+nW
	 1kptFB2Mg25j8ocCC8TqnY50L1d/vHMWsjOIPFjUqn4w2anTX1VUmAxp1ILqqn600KVF5
	 WhAFINgx7Vv8dg2Na/hKWv4otgsROi7Yw6XCtOm6iNsBi0XdjHX4ijO/U/D0LA+HzlFOL
	 Ppv7EVTrq0V0hmZYwfU6INajGAJ13wkS6oGBL2F9O95s7ir2tzdgBH0/fRRaoZRa7DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="e+Aw7/2L";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mwjndHqn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16F606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 17:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC16F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e+Aw7/2L;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mwjndHqn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795107770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuaICnb7sTsU3uMtAf1IdzJMLdxwJHMKKBVbfNsG8e0=;
	b=e+Aw7/2LZKdt7hvFQn2VmZ4pv2aU9pI9V5jda9Ip+lunG+IEWk/hYLmz7pff6pLh2IecYE
	Mb5ZkYG4AatANIMbX9JNlSWZQsYMgqEfPS+g26eHzmJxX9yPimF47XwgFg25VoGaf/7Rx9
	OShRVZ8cPyzxXTu+Fs4SlDyIAYvPdPA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295--HC2-cgAPRi7cuXHjGMCig-1; Thu, 19 Nov 2026 12:02:48 -0500
X-MC-Unique: -HC2-cgAPRi7cuXHjGMCig-1
X-Mimecast-MFC-AGG-ID: -HC2-cgAPRi7cuXHjGMCig_1795107768
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb8b260bb4so1515631a12.2
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 09:02:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795107768; cv=none;
        d=google.com; s=arc-20260327;
        b=BxkSvXdB4jKgbm4c0c2z2lWNMWYTO/umVL2KDgOu1JiHezNsnqFmIbqPydDO2WRTql
         VBhFp+hI/CABuX2LLKUJMugKvRjBGXguYmG+rZnM84BaNMRk8QaA9b0SSeL96kj0fGN+
         04UzqCwTDd3KeplBw63qony0Zri0c7g80OCOyiuaHZKSQ0LiLyTOuL1tvm9EgnUqcMdW
         8VBGJ8FJq1D1Qf6eXCYsR+gZjy+sUMY7WLxSq4ira5DbeFLkbUYEThBze5RHemrjsPaE
         RVTBsnXdmpP+ukw3tHmIlbZiwxuP5bRz6nrmeeK9bE83p7qRG1v8H4Qc3OjwvMDaugXs
         JK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tuaICnb7sTsU3uMtAf1IdzJMLdxwJHMKKBVbfNsG8e0=;
        fh=PNf/l5q+SsHtw1mDPFGPjjjNhfy/9lYJC7Jaa2yFFAM=;
        b=S0wAH4Smh+6+dyaaOaYcIEhTxitIW6k5h8TqwvxxUvbbf8404n+y+GLNT/qfQC2g12
         TR9/481vacpE+WuuypaPY4ffFfakjfaNKbPUD35dcnTwx9f/TXdL/EvvBwhP6YuXpkHA
         CQdA59DwWbywluPagkze/x5tRs5a06Qgy6FGdjLMIZ7JJVPSWbDe8B2R9YT3cHf1da6Y
         51tfOQIK0wfDvqVd8ap2Clk0AGQa2BmQ7OXv7o2KJVeMVzJ8llrRuFlU8nMxLUf1mDqk
         3+5ZKUm6wljvg/Yjzy3D5JJBp8O9e/Bkp2vYM6Sv4ywrWZus7zbeDul0FgIIMtdZ4U+e
         K0Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795107768; x=1795712568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tuaICnb7sTsU3uMtAf1IdzJMLdxwJHMKKBVbfNsG8e0=;
        b=mwjndHqnzk3+jjy6sSFSpNPWN0fmPAVFNcEZRoI9YAK7guJZuL5vZ9WIEE7aJMCJmJ
         mlMsskokIpB/KmyhSQw+D8HfDsEZXHIQ7NCqTr/7fsbh9BSX+uTLoXlNA1u3yIcET/nR
         bibjmHOMl4LQQksgyCu6IMBsPsopBKzhe3V6usadTbrJ94wbyA0UQoFwhPVerbg8c+Ex
         ODPmbyykIVND1Ua8NFTEG20PwdiQsUL8fe+Ybvdqm08s87ksPUcicI+LwonWOgJR3fIy
         myCOAEE+JrkUI6014flmAGRzpmTy9aOVbTbvbRdaosbGoRWybc7hX4IbtlY9E51CTFnv
         b9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107768; x=1795712568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuaICnb7sTsU3uMtAf1IdzJMLdxwJHMKKBVbfNsG8e0=;
        b=M5mxoSqq46fOU0QPrSK6wPaNWWQehyeVKhBzs5q/g0250wcjRjNOizeNZOfzCogzHO
         I30P1k6Oth5j2AQSsMY0qOLcDSCXzRSCoJKTTQLoOnNQX9pLHOTTtGAlKjPjXy3dNoyJ
         bhOYkrZYfyRhcboK+/xndUmHvVdbEI0I47xCnUAmr1aFWPihnD2PcsOXue8u+zbViiOx
         sl+FSlUYsDcXqUUOjtgkirKw6PTja5RFVN83Du5WOjSmXenmF9kdc3MsPPI7d65v4Nvr
         Lhnbe5vp/Y9+KcoF8TPJUMlwGaB3PFz9sKvprDsOlpTVNdYfTPA2+pNXn61KPzgJfead
         3MBg==
X-Forwarded-Encrypted: i=1; AL+hErHMjP7BUVZpE3NHwgVhVozkbZOUYJEBRoHbVshkN/natqXUO/TylONanKcv0pHzOA2FFTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+86xkJhZt/QXZbGO9TGYol+/TRB50aCBJkV4+B0q5G7VuTgxfp
	bgjRk5PuTkvs7aJz5FGZMtGPKQHDpAVoVGXoRQUWvuXC6+NaB+RVRs1hgJVMA2ho/oy9n3qVXA+
	S519zquz1xGW1vuR1X0xt4a6JI4+d8XicIhZnZ5IktyXO9xEyhShmiqP0RcBSw6gQxsCDBC1G94
	QJn0CjSK2dg7v4Bca9VezeKd7Fakwb
X-Gm-Gg: AZFdTZdp3VEYcO80v9PuIoao/F/avxpuUgOVfXEEWTKlLtpWFlUVXIF5F6hvE9SaAyS
	2G4gQJHn/92ei47a0mMMgOUP1xSFrR9zO4mgDVzDoOlTLwzbD/sKWTDSKUZQRq3wo5odD/jNhas
	zjHHe8+folnjr0qDd0Y2RpInYFHn6d2ga7NiWp2tksXZwHmyMHhAph6ZVRhXPA2Fj5PhtyiKlaK
	S8oIbv1Cc+5SWlwnJdKMNgixCXa+cIUKahxsi0RmXWlkLy0dBlwymYY8wmV
X-Received: by 2002:a17:903:1c9:b0:2e9:6352:6c61 with SMTP id d9443c01a7336-2f03f15511fmr4875175ad.19.1795107767409;
        Thu, 19 Nov 2026 09:02:47 -0800 (PST)
X-Received: by 2002:a17:903:1c9:b0:2e9:6352:6c61 with SMTP id
 d9443c01a7336-2f03f15511fmr4874595ad.19.1795107766796; Thu, 19 Nov 2026
 09:02:46 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119125608.3939330-1-maz@kernel.org>
In-Reply-To: <20261119125608.3939330-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 19 Nov 2026 18:02:34 +0100
X-Gm-Features: AclHuK9gLqjDXNyNzrRYpnTsqE3NQnqKer4SP-4ZAj4I36D5tykUXBkj1PxU_-4
Message-ID: <CABgObfaXpZsZ32L7gkW1EhuYwt0mkwTueyW9=BDBpZr71NCmuw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.4, take #3
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Colton Lewis <coltonlewis@google.com>, 
	Dan Carpenter <dan@pereq.eu>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Michael Reeves <michael.reeves077@gmail.com>, Mostafa Saleh <smostafa@google.com>, 
	Myria Sarvay <myrialsarvay@gmail.com>, Oliver Upton <oupton@kernel.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Will Deacon <will@kernel.org>, 
	Xuheng Li <xuheng@cs.columbia.edu>, Yureka Lilian <yureka@cyberchaos.dev>, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 1:56=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Paolo,
>
> As promissed in my previous missive, I'm back with a few more
> presents...
>
> This round of fixes is mostly a Dan Carpenter special, as they seem to
> have hit the jackpot with some new formal analysis tool, and found a
> number of issues in NV. I am very surprised (/s).
>
> The rest is a bunch of pKVM fixes and workarounds for ugly hardware.

Pulled, thanks.

> I will be back next week same time for more of the same!

I can't wait for it!

Paolo

> Please pull,
>
>         M.
>
> The following changes since commit 181a701fc14d3d468c603b5ecfb9f12115c5fb=
72:
>
>   Merge branch kvm-arm64/misc-7.4-1 into kvmarm-master/fixes (2026-11-03 =
18:14:37 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.4-3
>
> for you to fetch changes up to 3385a832525527801012f5993d1f6a7a3d23092c:
>
>   Merge branch kvm-arm64/mmu-fixes-7.4-2 into kvmarm-master/fixes (2026-1=
1-19 11:16:29 +0000)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.4, take #3
>
> * MMU fixes:
>
>   - Fix arbitrary truncation to 32bit when dealing with pool size
>
>   - Correctly order page pin refconting
>
>   - Prevent a HYP block mapping from being replaced with a table
>
>   - Fix NV Range invalidation by extending the boundaries to the
>     next block mapping
>
>   - Make sure the correct hw_mmu gets picked on the first run,
>     should userspace restore a nested context between init and
>     the first vcpu_load().
>
>   - Reject TLBI IPAS2E1 that fall outside of the S2 range
>
> * System register fixes:
>
>   - Correctly forward POE/PIE/TVAL EL2 register traps
>
>   - Add a sanity check for missing trap forwarding
>
>   - Correctly hide generic PAuth for pKVM protected guests when
>     the feature PAuth has been exluced from the feature set
>
>   - Make sure that HCR_EL2.NV1 is always RES0
>
> * Misc fixes:
>
>   - Flag Apple M3, M4 and M6 CPUs as having a broken vgic and
>     a wonky PMUv3 emulation.
>
>   - Correctly handle 64bit offsets into an MMIO region from
>     userspace
>
>   - Ensure that a vcpu is loaded when injecting an event
>
> ----------------------------------------------------------------
> Colton Lewis (2):
>       KVM: arm64: Force HCR_EL2.NV1 to RES0 unconditionally
>       KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0 when E2H0 is NI_N=
V1
>
> Dan Carpenter (9):
>       KVM: arm64: nv: Invalidate whole L1 blocks on TLBI RIPAS2E1
>       KVM: arm64: vgic: Don't truncate offsets in vgic_find_mmio_region()
>       KVM: arm64: nv: Initialize hw_mmu to NULL for nested vCPUs
>       KVM: arm64: nv: Forward PIR_EL2, PIRE0_EL2 and POR_EL2 traps
>       KVM: arm64: nv: Forward CNTP_TVAL_EL02 and CNTV_TVAL_EL02 traps
>       KVM: arm64: nv: Report EL2 registers with no trap forwarding
>       KVM: arm64: Load the vcpu in KVM_SET_VCPU_EVENTS
>       KVM: arm64: nv: Fix NULL dereference in kvm_pmu_nested_transition()
>       KVM: arm64: nv: Ignore TLBI IPAS2E1 above the IPA limit
>
> Fuad Tabba (1):
>       KVM: arm64: Hide generic ptrauth from protected VMs without ptrauth
>
> Marc Zyngier (3):
>       Merge branch kvm-arm64/misc-7.4-2 into kvmarm-master/fixes
>       Merge branch kvm-arm64/sysreg-fixes-7.4-2 into kvmarm-master/fixes
>       Merge branch kvm-arm64/mmu-fixes-7.4-2 into kvmarm-master/fixes
>
> Michael Reeves (1):
>       arm64: Apply existing Apple Silicon CPU workarounds to newer CPUs
>
> Mostafa Saleh (1):
>       KVM: arm64: Use consistent type for pool size
>
> Myria Sarvay (1):
>       arm64: Add CPU part numbers for newer Apple Silicon CPUs
>
> Xuheng Li (2):
>       KVM: arm64: Don't replace a valid hyp block mapping with a table
>       KVM: arm64: Order a later pinner's accesses after the hyp mapping
>
>  arch/arm64/include/asm/cputype.h              | 28 +++++++++++++++++++
>  arch/arm64/include/asm/kvm_host.h             |  2 +-
>  arch/arm64/include/asm/kvm_pgtable.h          |  2 +-
>  arch/arm64/kernel/cpu_errata.c                | 12 +++++++++
>  arch/arm64/kernel/cpufeature.c                | 12 +++++++++
>  arch/arm64/kvm/arm.c                          |  8 ++++--
>  arch/arm64/kvm/config.c                       |  7 +----
>  arch/arm64/kvm/emulate-nested.c               | 10 ++++++-
>  arch/arm64/kvm/hyp/include/nvhe/early_alloc.h |  2 +-
>  arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  4 +--
>  arch/arm64/kvm/hyp/nvhe/early_alloc.c         |  2 +-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  8 ++++++
>  arch/arm64/kvm/hyp/nvhe/page_alloc.c          |  6 ++---
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c            |  4 +--
>  arch/arm64/kvm/hyp/pgtable.c                  | 10 ++++++-
>  arch/arm64/kvm/nested.c                       |  8 ++++++
>  arch/arm64/kvm/pmu-emul.c                     |  3 +++
>  arch/arm64/kvm/sys_regs.c                     | 39 +++++++++++++++++++++=
+++---
>  arch/arm64/kvm/vgic/vgic-mmio.c               |  4 +--
>  arch/arm64/kvm/vgic/vgic-mmio.h               |  2 +-
>  tools/testing/selftests/kvm/arm64/hello_el2.c | 15 +++++++++++
>  21 files changed, 161 insertions(+), 27 deletions(-)
>

