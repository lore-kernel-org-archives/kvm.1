Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB748CD5A
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331714; cv=none; b=fo+vuQgTCYPpp8dA0j0QrdkE/Mqxu30j/+QojBHGT/66IR80RiRbReM7vArgEgA76WvR5KEMWL/mGP/2SgQxUtnNhrwlFzvtZKOdqQcpXMs/qtJx3ik1v9pz6yUvecpoAbF2T7Sa8EyjIORfgowmkVoo+2sRwmIivsK1WwSHGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331714; c=relaxed/simple;
	bh=uVa1dC7xe1aAeUnbgl4sqICBfeNILVt/mq2OEqNA2R0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K0kBRHaoyJaLVkAo3IyWQsWqE9ksu00GfpdJA4WQsmB5yF5iDvjLyJVq8vuINtC7SvKFS3PJp45cw2IQtT+hJC8hXnEmVV0EqbVG1YI3x56Swnv69H/mP6SLPpXjXYk2NaKLARs0m5vwA0wMgR0cNwag3sNq0iQ7zz7LD+9nzWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckAjqehW; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckAjqehW"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbbb9c9bfc3so580807a12.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785331711; x=1785936511; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1Uw7Rea6IolmWTWAWQHNW+WUS1KBbg7Hs/3YV9RZGI=;
        b=ckAjqehWOD8MMdB+F2dd3eTtXw/eWtYm16W8bM/TGPvB4e4w1aD5gz14U114W6Mzyb
         njNpPIRdYeQ11bG4ms84qyiqQJlqIHTAGo71aOFXmhh3/jwmcfwhMtpzeR6Afd07j5BQ
         I2nNI1QKGjjbI03CkpGKri38Tso8TXLMMz1d2SoOelvxXQ5aK6Xc27Xpha8JqZkNFB1D
         07hRGzP9RQkNU3a7XsAY8G2Z9duJKnLu53mLsGhSgm3Bih+k44KpsWRbILfOF95EXxO5
         fJ8Dpm6S2/ArRervx08+F6nBbxYt6jcPX/Aujrtb2htw7uUS2ML41RfOo4cdOJzzrbwR
         idDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331711; x=1785936511;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1Uw7Rea6IolmWTWAWQHNW+WUS1KBbg7Hs/3YV9RZGI=;
        b=CXWX4dHwwdiOjSzFi8eL2xLvgaQEeUbKKNEu8li6DIQ82Jmh57ZIXtuKz4EXKJ4iR8
         YbG+qCTi7d7E5H+bE9j4MJALuOIcTqoD9uFur9WR98pA1p2jH3CB5rAb9VkIyYi3T8U6
         4j2/oiQXzynlCaGzU8aVPVmaBRrK/y+2CM3aAR35Yb1xF2eNi9tna9Cafhl5pzEbRn8y
         iSeyJ4QLcscYyvrepT6IfoIIN6ejkdd1YFdpQejwbHXwxg4uVBMPPTM5cHjVfQeUWImC
         GOKiZeOJ4amaNl3yCNcm/k0Erb9vwqhXUaK7oxVdJzXxk7fYhtq6WjwIE+miQgLnhGm5
         AgbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3qypowqCEbFz+r/ErMY5PfaArG/x5aAqGqQpGwjIDxmoKQ9KuTJ30mbdMGmVuHvlJZY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOcTpJ+mHcDDVbw+GXBx+U5ceccpFKsv0h6fdkv6OuZG4O5ZOS
	RPtiAtZy5hpsIvi9k1u0VFPJWI7I//ARoAoA6YERBtzQX5sVx6CeDXVeRzEFdMmYUyqHccq2q8S
	FqttPfQ==
X-Received: from pfcf6.prod.google.com ([2002:a05:6a00:2386:b0:847:8e58:df6f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:990:b0:848:2f74:d8d0
 with SMTP id d2e1a72fcca58-84e934463aemr7142102b3a.65.1785331710486; Wed, 29
 Jul 2026 06:28:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 06:28:29 -0700
In-Reply-To: <20260729085908.21368-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729085908.21368-1-jirislaby@kernel.org>
Message-ID: <amn_n5dykcLAHVoz@google.com>
Subject: Re: [PATCH v2] KVM: x86/tdx: Do not print error message on
 non-present feature
From: Sean Christopherson <seanjc@google.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

For the scope:

  x86/virt/tdx

because this is no longer in KVM's purview.

On Wed, Jul 29, 2026, Jiri Slaby (SUSE) wrote:
> Before commit 165e77353831 below, the kernel did not print anything
> during boot if X86_FEATURE_TDX_HOST_PLATFORM was not present, unless TDX
> enablement was explicitly requested via a module parameter.
> 
> After the commit, when attempting to load TDX automatically, this is
> emitted to the log:
>   virt/tdx: TDX not supported by the host platform
> 
> It is emitted with the "error" level, hence it is disturbing. It is not
> an error to run CPUs without the feature.
> 
> Drop this silent-boot-breaking error message for the automatic
> initialization path.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: 165e77353831 ("KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys init")
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Chao Gao <chao.gao@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>

Reviewed-by: Sean Christopherson <seanjc@google.com>
