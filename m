Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794926581;
	b=cUyxQLOkXOAV8LFITN3NM/MjemCgPw4eXWg7WE8EyJ/lCTtHq2zo9QAfBrrzwG/0Cy9v
	 FnWUS9aO/J7LlSujc8L4NyIzZtZc+0Z9TU4QSyqLWJ1aVnx/2tOmNYN0FCVNChPefH1vT
	 yEDBb+cUXQPc9TBoY+sbxG61nW38dIOy4gcxuixGCeKZEHNj7fO4Lvy4LOHRTNqG3mRB5
	 48ABBo9GvB69qlcBEjCwQ49lig1jZFK7HgBVD656wUl0iJhor+uOf6cliinkQblY/DBVS
	 gZCLSd0zGHuq0UVcPna3TKaoJvEjYhyTUL13PRciFkgQRT7hVn5nOi1W4SvtkfBlNEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=yDy1XcgDWZwINenyHLTABAspaDvRGL9tl++CNqH98OQ=;
	b=C2Edc3yAnwePRhkSRqbHgzJLEZSXRjPZPx9oW0+U7uHSqtkma7/hZ8hQUUNvP2CpGss/
	 FIfjc1lWJks0IyZkadvJ1O4IYi0xFXLRKC7OGdQMu7RKRMiJ8xmSpro8FKzis9X6oCaX7
	 TPjtfgtQz0vKrJnTzLITFjX027bVdx5gDIxa2as1mRk4CDfiTJpKUqM2VFRjjmU1hYfAR
	 9dxWLatRvALDFzyLtf4U6tUzTTVAyP8HpAt6L1xMX8Dz3H9Kz19PPevYXwok4LzlU6DZy
	 fv7EsPgLoyIyUF6I+kd0KbuWfZ8OA9OW4Sd0hzmd1z2WchWKs563P7afoTrjKxp+IAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=beGG448l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB012606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 14:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB012606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=beGG448l
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so9856e87.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 06:43:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794926579; cv=none;
        d=google.com; s=arc-20260327;
        b=dbcKxHEqrcHcHY9XimxK/Cva8SHaMwqKtxThSiNQMyQCWufn2ELCB7l3/U3i3So82B
         lnjXIXixzHXjC9TpQfKuxYZ9QzUvhvwXsl4Ph6kAmgXUzQSmoGiACm+YxhDfKUITKwUV
         PuvGGuW2sQAMiU6hCYx4mwikA2Swz2ApT20hQkkXE/199yOH1YAFJzLIiWkXvO3z4rX6
         134mrQCVJfb1KR3Cywa6g0y0pWT5ZmZm5+XKjhz10MFM6kMMAgyOCscsGMN49UUU+t7p
         329qOmm7FRvXnbUzOsP3jsp3n/nVzKWBVc8YHGT/Ho/MOZawHFc5QDIc1PWrCW9665ZE
         VVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yDy1XcgDWZwINenyHLTABAspaDvRGL9tl++CNqH98OQ=;
        fh=ShOtn3DH2JacjDhhRuDN/ZzoL2uaqKg1U53ZjQaTW3g=;
        b=YOWcupE+CrAUaYtIA57gd//A3FFsj/aq3uJRwfr1ViAa5ceO5soQ+8JMaokTj0WOab
         EY8N+pmMTJQI+bk59gJ3RdZliWskZcnjtox59ItbRdCy+6sZOL/OZpvEo+XQrXJ9FWCk
         iiycxaSCi6bZcyfmtMat4pCKrHPMsWe+MKpidZ+9kPcnjtwvjC8OLXPl3flVVq6AzDuL
         7ZwBSRhk8pE5NcoKHp7kCt4dwUBnW+lawD9Fb+0j0uJjumz8XWdr6fYDRyxJTVX1RMik
         +pJFQugzRjCpFGxdT/ExfRbxLFSyld3H/h8h6LIrE7ZtTou2Q93ECn1Qsy8XH2lY4UuB
         dyXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794926579; x=1795531379; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDy1XcgDWZwINenyHLTABAspaDvRGL9tl++CNqH98OQ=;
        b=beGG448lWY+cCFhwDLViggnuSIAnECspaC/19W/CcA+kp/RDHj8CVHZPNOJXzdPNBy
         xNbS1BVNqeOCH6NHPcTuij1m6boVLv7Kp9nMmUiKBwmJrLGwJaPhYHlo1udSVZMv4l3l
         Dp1+o/6488K6P7DXJId6+UZsQzhFV7baivBlC42qPBJyayMCJxxYRkn3fgpxH5ongY/u
         PBW7ApegBFS1de77Vsw9jKyfh6Syy4tHkh6gFUOKf0C6Y8a1Wv48YRtCTMd/zCfmvlDC
         ahqLCKnNqJqAeTfUAYtkHHijaUOlKhR04crwSAUuFeBZulo5g4Hakr8qGq5vHEUdXsyY
         rFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794926579; x=1795531379;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yDy1XcgDWZwINenyHLTABAspaDvRGL9tl++CNqH98OQ=;
        b=ypLW8u9o0EtYErR9EmZMOXDtzBOAwtGPdpiU11QG68nxeCb+yMQuTjYxijTLKMuNZT
         jU/3bwNoL4i+d8OXIquz4WQ/y77SUCfU6bX9bJns6cD2UxzBj1aNYBHOelPK+qfX9f1X
         qY41Gu8RNDecBGReTqPiFi0Eno+JFWveN7O6fWRl2qbTUCf0pmBHmdHoMMX3iz1eTFx/
         nbxTQpQQWY75PpRm/4jU+QD6MmUyGj9sYRS4KBMBzq3UXc2Xx1xEZuJ+HOrFvRl+1+oq
         otY133NTf6fkL5AX9GN4nsXpRjbHOJdK5EnfWGgRiccC9o6vX+Ex1+v8gp02967AVYQy
         JamQ==
X-Gm-Message-State: APuU4Z/qPT33vdZb2yympAFN77enkIBCjc/eYW6FsxC/p4NYANm5cX9F
	Nl0bXFXDsOzTiyeA6bSgCTDst3PIiNRwFAdf8bUymkkANhm4Gp9AeThdq2bEE6xNg0aFna7AviE
	JjWw98gK38ObVW6IZwMsu1/MGjfQVGDZ0+zXPCdyS
X-Gm-Gg: AYBFou1c3qiV6DXcAYDHRwnMWMBm97t7osbmBsZQpCtr7rKftJMdQ4pcYnjMkEI/yMV
	wyqaoImVsMAArsJf/hnwaFusNSplpq+QXYbUHd7z6sXlesBSe1v4Jye9TS76t5umXeB2jmwgEto
	+kA1DP6BNVgy+Ha+Hd4M6f85YXDyggTPNjBGQz9pauDVaJSm8CzSk3MDl343HDbGsuYz3y//m/K
	RooJd/2cLe04jZldDuqxOInKe/aXiQ6H/ujJUhwyohfHmqJxL/sAjIHTJaFP3fXpWSjiV0L257h
	upyzt5lXYtTDXZSO01f7xzNk/3WI1acGmKP39n5QczwXN6gyngVBU8NOKp+T1meV/azUkBSxZXl
	J7w/Lk7STxQK8n8gZ2udZ2YIQOgq4eROnqiQ0zhJi82DbxhLO3x2essa/GDL4cKDx7R7txWAyO9
	qCLhf9fXWOIHom568jJQl9/3w/
X-Received: by 2002:ac2:4e07:0:b0:5bf:f84f:1d74 with SMTP id
 2adb3069b0e04-5c1a2185fadmr144874e87.13.1794926578238; Tue, 17 Nov 2026
 06:42:58 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116164358.142785-1-steven.price@arm.com> <20261116164358.142785-9-steven.price@arm.com>
In-Reply-To: <20261116164358.142785-9-steven.price@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Nov 2026 14:42:22 +0000
X-Gm-Features: AclHuK_cj3TGdQobS2sWbu8813m5UwP4GVfoFkRYcpiUN0Z7bFACWbcVhIVAqkY
Message-ID: <CA+EHjTzAo+5FhtxfX8mQ4t3k5BhatR15UKNSAQw+CRbxJ=wz7A@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] KVM: arm64: CCA: Prevent memslot modifications
 after Realm creation
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 16:43:54 +0000, Steven Price <steven.price@arm.com> wrote:
[...]
> Define kvm_arch_has_private_mem() so generic KVM recognizes Realm VMs
> as supporting private memory.
[...]
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
[...]
> @@ -1611,6 +1611,8 @@ struct kvm *kvm_arch_alloc_vm(void);
>
>  #define kvm_vm_hyp_is_distrusting(kvm)        ((kvm)->arch.vm_flavor >= __VM_DISTRUSTING_HYP)
>
> +#define kvm_arch_has_private_mem(kvm) kvm_vm_is_realm(kvm)

Could the message say that defining the macro makes
gmem_in_place_conversion true for every arm64 VM? One visible change
is that KVM_SET_MEMORY_ATTRIBUTES2 on a non-Realm VM's guest_memfd
returns -EINVAL instead of -ENOTTY.

[...]
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
[...]
> @@ -2887,10 +2903,13 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>                  return 0;
>
>          /*
> -         * Prevent userspace from creating a memory region outside of the IPA
> -         * space addressable by the KVM guest IPA space.
> +         * Realm shared IPAs alias the corresponding private IPAs, so memslots
> +         * must reside entirely in the canonical lower half of the IPA space.
>           */
> -        if ((new->base_gfn + new->npages) > (kvm_phys_size(&kvm->arch.mmu) >> PAGE_SHIFT))
> +        ipa_limit = kvm_phys_size(&kvm->arch.mmu) >> PAGE_SHIFT;
> +        if (kvm_vm_is_realm(kvm))
> +                ipa_limit >>= 1;
> +        if (new->base_gfn + new->npages > ipa_limit)
>                  return -EFAULT;

This check still applies to every VM, so I'd keep the old comment and
add the Realm sentence to it.

Cheers,
/fuad
