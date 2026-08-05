Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6E3EDE42
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945772; cv=pass; b=I6CupoEprLpJrTub4bpUJyy4mwsMkeYINFTjl8lUEtfJqJ3k1QhN7LFaL5o4IH5lJwRb3kPg5NOYvmjd77ZmVBFcUWpIRpo4nNWTuLKV/vOu/lbCRBh40S534mqB+Qwbt7113INis8tf7WBrHdrp5GWG25Hl0ZUDq1ktdVGh0mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945772; c=relaxed/simple;
	bh=urqjPATeIdTfgUOdfXyZZ1lXjN9fdXK4VUOiuTSdems=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7vogHJsSLinwmWM6DbuNi/+Lem5zwxxKUJwwCYY4Cn7iyE8RDwlPsYiKAcziXj/NUtquLzTwhuUh6/FFVKO0gNYWegOTkG/qOEsyRcY8KFThB1wkQZYJy1ugDit0I679QhoxBJ9SFRuLS0RcAyD6g6rQ0NT+AeBj2bi1EEJJGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHeCl0OG; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHeCl0OG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e347638adso1285524a91.0
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 09:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785945761; cv=none;
        d=google.com; s=arc-20260327;
        b=sZ9X7Zf3K35J58jgsLdkjZqi47pWFbakQwGq+I5phbXRFd3pKe2+XEiIcOAR2U2UMC
         vo25m6R8AQV0JdciFM2S4r4nLT/lyRN5uIN+LkN6E1AgtWC596A9EZkp+AX83J19UHBL
         rbcTrnn4cBxMz43VvL/pSnw5RJ4pU2VVKTabSHxspXg2Ae6EzxqZoZWcaWqCWPTymMN7
         WLFvDugLln6Mc00Lg8Mf75UaoayhVKfPkaMxu6v/pc8eaZN1jVt8/C818f3E4w5pWMCC
         r8AaQlod50xZD0dEUsF3QhwvTTro/qBLqVsIXiEt1aQ+B1NdlREB0qUVrFGVlAbA9eZe
         0IBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dDxVaJA0qLhUpRmzRVBWfrwvszjITp7kHu2WvQfbt0A=;
        fh=57MkjwnbybMKssYOyCzy2153Vev2vrYV4VU70uMMoiE=;
        b=hB8SzBSkinCTPgpCraNEhW5Y7N8OsrbpqQAVTZAynLN6OvzFAoNf8f0tD5gXNos7CL
         PYAxvfYURhb4/53Cie78ShaJS1f+lBUcao9P6nz1olBvU6zLhE292J9QXzbg3Ch/w7QY
         TGEQqJStTAKa+S6RWTSyPOJnWmYSvf1m9glTPR2MDt6jbKnSfwUNCOIRLn4J7MZEg0rz
         3nzTSA09j9myL0MgMBqtCwNIlutmtzDunCmOhpDo+QgX8DAKa16y1IetQEJyaEDrahor
         /S3mYtJfmJF5hUaGKyrOLkeVyw56MrYQ2rpswkzfkbhV1oAVU49KGGKuN+a2pL+L57NF
         +dOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785945761; x=1786550561; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDxVaJA0qLhUpRmzRVBWfrwvszjITp7kHu2WvQfbt0A=;
        b=EHeCl0OG2eG0nUAMg7DYEoUZ1cMlqJmTSWktmQsVgl2qnNRWnsAMPu7+QYNy/HQpd/
         9sf+O2/tndbLiIw3e69n/jRhvocW0nzjqoaofaKuMdhM+dQqUZLmZGc7VjcTxO4iw+B5
         KUi7a9J6M8TLHUPZWUhit0fIDIswhnwCB+relMLigeHVMr5tYs/4MywFecqgRfl9yh4/
         nFy3HaPjm2/dsVrd1FxJCPUO/YdvTiEYKjyBFzu12sTbdBME9002eYj2bEWBFoiwBMAI
         XeeWaZ/BPJSTrIHYSmTiCkMjoGHuxCyFzuyruFzEdZEtZapyWd+9gK3XbZJC4PcSgifT
         d9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785945761; x=1786550561;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDxVaJA0qLhUpRmzRVBWfrwvszjITp7kHu2WvQfbt0A=;
        b=BpMleST5yhHIKX/617sXePCbl5XYYUnIbGN5uXYSdogNHG8afNA+q8NMDkb70WnNTm
         bwqLJgvwP9QWuhZnjJeCqNoAmxxPpTj+eI2tMAV7HgUMkoiOVEZs8mNrp97ZOvryV727
         ojz7zm3nCTOpmH10U7f2AuCGnf+QkeZJyI3egkmrIp1Z/H0thOIigQGQPiJNU0JZ0FkT
         mxCN1WKzF0BDBuBwzb649mEwfkmU5sNwYB69wBxBTytMCdS2gj4nLCQGX7yRSlgd1RJ6
         OR/kAPCShLtTIAq7w4fkmNurkYtyXnctPHnNVqTk1FGU5J+uiqsc5L/HCHHIZnaVpjNq
         6yKg==
X-Forwarded-Encrypted: i=1; AHgh+RqwptmT6cziDjK7uSFXbl8a7DesvW7NJap2WnGdYF4ejwZuZ+qk5VzLmvvMGr+o4yLYUxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOshHfAywn9TeAF2Pf5TxUTslJf7PE5SVG4Cw6hvWEZKsd465
	mHomX7Z5C5pptS4z/GtH5smPvBBcSz1LJsJNXK/bHVJFYNaouzyWsSaeydHvvCOmvUmG0u0+uhH
	ZzgsrgC5t6MXJyDWfrBaqHIpLvBhVX02qS2P+GSHd
X-Gm-Gg: AR+sD123K5Vopqu4AKvCUNglMiHiwj2AX1fJNpe4LF6ZqjrcH6Z8J33drLb5sIy8mDw
	mg+AHYcrE8hzrmWwrtQl00GSLhcKflwhkiWClB/AYEf+moKnqNfg21bypcVuDfGadeqeYtHEd2e
	1NzFtDzo8DO5BnUmUyrmn8BIKk13rdvhrN9HoDh5eWYZ6DpLknf666T6cGgho/hy5WnTsn7X7B3
	LrVi2XUjH82nr7lmVBD2W4GGmTqxcrrkw7QSO60zVahZh7RB+2Ur4BTwUMee1YULL9Q7LGflqpv
	UbNRt8PX05Dl2JwIPS+1lKlNL+fCkTxF4PblrKFsAERjyxOuwBQGgs+pLstUi37JoXszyU/YQZO
	EL9OFA7nRaPTa8sfq0wXW0yMMYuT3Y3C6XNs=
X-Received: by 2002:a17:90a:dfcf:b0:38e:9045:babe with SMTP id
 98e67ed59e1d1-3903c5589ecmr8554536a91.7.1785945758439; Wed, 05 Aug 2026
 09:02:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Aug 2026 09:02:37 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Aug 2026 09:02:37 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260803134403.80630-25-steven.price@arm.com>
References: <20260803134403.80630-1-steven.price@arm.com> <20260803134403.80630-25-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 5 Aug 2026 09:02:37 -0700
X-Gm-Features: AUfX_mzwYvzVqQkuKFkuAOMZ9a38FvddXqwH3nl4jjle1d5YB5Md9uRdePzF8HY
Message-ID: <CAEvNRgE5O4FcNQDHwh+DWsHH7gLs3qzm+L4ZQ9FHkt=WoTV2Hw@mail.gmail.com>
Subject: Re: [PATCH v16 24/45] KVM: arm64: Expose support for private memory
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Steven Price <steven.price@arm.com> writes:

> Select KVM_GENERIC_MEMORY_ATTRIBUTES and provide the necessary support
> functions.
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v14:
>  * Switch to guest_memfd in-place memory conversion and drop support
>    for KVM_VM_MEMORY_ATTRIBUTES.
>
> [...snip...]
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 15d42d1993bb..146c52f867c0 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1510,6 +1510,8 @@ struct kvm *kvm_arch_alloc_vm(void);
>
>  #define vcpu_is_protected(vcpu)		kvm_vm_is_protected((vcpu)->kvm)
>
> +#define kvm_arch_has_private_mem(kvm) ((kvm)->arch.is_realm)
> +

Perhaps related to Fuad's question about pKVM and CCA state: would
conditioning this on is_realm mess up pKVM?

>  int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
>  bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
>
> --
> 2.43.0
