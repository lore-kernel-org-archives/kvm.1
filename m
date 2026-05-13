Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED77347FEC
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691735; cv=pass; b=hQnoIAB4yZ+Z2zNXi/vMPgGfFOuD4hRU1SeW9shHwqzdKB9pLf3wKriDgvn/7zYIaS71vYwf+77sCZ+ZrgjihqZqY+VVexXioyY8Z0qEVjBJkEtsKUr0iT2cydvuPqjyQVyP5pk8+gPPU574kWXnM/B+nJgM2unO2hP477VxXqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691735; c=relaxed/simple;
	bh=jDAM/QoVFszMIUFczVb386HAVy8pWg4u5py+ckvmY84=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blBJ2F2bIrsvgVCuvCh4UCumo+APYMr0lds0Q0yj2c3YF71cfDnyUFVYkQ8j6iSsSusZXbsHQw+U4fZNiTPjJIigWnIU+ovQfjT/U8MS4m+9RKJ5a6QxWCgVAQ4V00fl+Vg8lKyMCEIehMMGWwdwHLmYO8qRxMfSRyJbUbxahV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChUr1rWp; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChUr1rWp"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56739adfa1aso4720081e0c.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 10:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778691731; cv=none;
        d=google.com; s=arc-20240605;
        b=X8apb2i/EIGiX2Nc+Xy7H6NqQlM1XaTQtf7J/24oxbTcvjIZEoYit9A5kwJS73GuVp
         2JRUnSG3DgcXOxkptFMZFlxgWkwOa8onb6suUb5WTkKbUTBGsfw98FT/WHYontlnj7Ob
         idl9HxbF3Ps8QHtCYITtuA90xeMv2PKfpJ8OsgmnteUSQlnzmc0ghnq2YVva2ip87ADS
         0P08NmQZdEiJ0ruQHkFJVsSNLMVspTiRbOm28I7XGEitrH8+rcHlh6W2qG0UCyx15VPz
         lTVScEE4hvowEKs0q9MAK0vxx4atJjIwRWvVQdlxEuqmICmvYo3DWPN4w84u8dvh6rdL
         uQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=h1pqwbkD9RQvoJKBcu1L4mkhOGVvcWwZWBB66EXM0+c=;
        fh=EmJCcYyW/0ZFMwYFZpmasaMl7xE3/LfIlvc1WKjy1BE=;
        b=YOaShibd+7CtVPHWCOaSVQGZY1ENJuahMFss34EnmNWlB55naXZq3brOef8LpcjAq0
         lWCeJOmBVveSCVBoI6VV2lgNpv+M5IKp861dSwEmWGuwizzvauS1HcVMRiars/AZ4k+G
         9/pAypiafxDcdylR1vSK9gGiQUTsK0uPCLZ3+89lef3ZGxJ+wPqW6NbzMGadtKPgvIgU
         7eI+mUIWx6gF5eJePt8sbfCEzdfET0A5RsZCQiUUVknwzbtmhhglO8RlJI5VwnPNHGv8
         T+CSIux8YKLTVIEuNAua8L0Z1PdxLvbmKtDAHuXiwvzfhUbwt+1qYON7hJCdk1dVuUC4
         vxLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778691731; x=1779296531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1pqwbkD9RQvoJKBcu1L4mkhOGVvcWwZWBB66EXM0+c=;
        b=ChUr1rWp5wbUCuXE3n7KVlYQNbATYj2chSJ/BIoj2Bb10/sujONfkRpTPfqtRe0WMt
         UVfEttt0I4NUoetYb9saFW6/0X/ZiSQ5m/cDQEXszm8l/z9ftyG5c7vIoUSz46UUWq0c
         Lg3cjmqeF0ewfHyUEQ35JJ7UZcqudPxTl1ue4VfwuhY/wZOcTnbhjX3Ff8m4hl0DGI0e
         ylG8zuKVfdJ3cQXA9feXGs7z0bxFkIXzeKXGv6EwiPI7K1Rsxa/rwaVYYeL99yCuAet5
         stgmDc2XfJYP6yOOlOMU2CY3gTCIq9sh5iLKfdoacTGbaSCGlwbz4FmtLXMX7FSrHzv2
         nA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691731; x=1779296531;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1pqwbkD9RQvoJKBcu1L4mkhOGVvcWwZWBB66EXM0+c=;
        b=YGP34BxfJjQlU0T4M+Mzopdl4VWdzbK0edXzKnVL8ovFqR9icpEqKc096ncJapwXiB
         JE243u7IiSF2AYSlxdM0Gvh7awwS2iBjdc/rq0azBBdV10m+D1/rvyCJ4a9vx7GiTZ76
         k4vC6Bfwha+WvRrLjnaYRDtLcd+umLB/VSXsHlYN6GzNaA+bGay7b7CREme4zZHnRAR/
         96RUtFyFK+ZfYFoiglSDVLfQGeZ10DbMTWFpK2wXKVMaXx42T1FaynsGtrfegLM5GtDx
         h5Q2JiCx9udl1TAHvKyzTMDXMaHyoSVOTHfUkUnLD6FrDzYQXGB8x9H2EIhQebnAeYL1
         AvbA==
X-Forwarded-Encrypted: i=1; AFNElJ8aFeXbYXR22q8GiiInp5hqSc1leXycBuzh2i4uiNOZe6Mqq/PFYGnShQBlBredZ3d4d0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rS8Rew0ZHCbpuGmlcLwGyOIWh6NfClyULPDgArYeYQwh1rVE
	iSmwbIYfgF8v/fZpYLCLigFDjzRhldOjlRsYxNHZYH42jC+6wutVwr+kbgYSKVdzxxf6T0bqxj+
	+zdR/tu4vZC0qx/vq5BsX1//ntD+DjME5ZzYkrbQD
X-Gm-Gg: Acq92OGU1Y0hK7sWWZ4CJjwp4PN/QIIWmpnWUitjyuoD48HDy5JjQJvXc+0AE8BbMzW
	i4Dsuz44MPre6HPjRen8CEl2aT9zRH7LCGfDGa3MMxOB7w3HHezmd+MouHVO7nYafX+Ild386ct
	x8vC6XacCwz2j0vrvTQKcXaNTZrGwcBFwzuEWIP1aQ+jKSK2NYPAsirS0FjHrzbH+qOkTHia0Fr
	7Hm9c8QOGI7dtFR2vjLWi/OIgh7N5oUFD/5Sx5NPKABcs0WQCPixaBovXKesCVrUyWecHQviZq4
	HDRPHD+hDANCqshKfRgYYQ6p0uuBP6cwDTPcqi4deWLjzKU4F2MRgVXB4mK5g4ohsETwSFvPlXI
	vs6ee
X-Received: by 2002:a05:6122:1057:b0:56f:bb91:4861 with SMTP id
 71dfb90a1353d-575e6b7c6f3mr1887453e0c.0.1778691730803; Wed, 13 May 2026
 10:02:10 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 May 2026 10:02:09 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 May 2026 10:02:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <agSCDrazxEvStSuI@google.com>
References: <20260508015013.4108345-1-maobibo@loongson.cn> <agO6oLqQYQG14x6D@google.com>
 <1a5a115e-3bf3-e2bf-475a-b49f5b6e308f@loongson.cn> <agSCDrazxEvStSuI@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 May 2026 10:02:09 -0700
X-Gm-Features: AVHnY4IZCymsWlyzXzbzCIngna9ZiTJGyW83ZiodmvC7A2JtAcOCvGD1mOGMYHE
Message-ID: <CAEvNRgEgTf2a_KCZiw50T=AXAgmYqLPpXacDePwdXTvT4O-+7g@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Check guest memfd validity with flags
To: Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Oliver Upton <oupton@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> But, Ackerley and Fuad want give kvm_vm_release() the same treatment[*], at which
> point there's no good reason not to be paranoid.  I want to do that in a dedicated
> patch though, and harden "everything" in one shot.  I'll send something like the
> below.
>

Thanks!

> [*] https://lore.kernel.org/all/20260511113759.610924-3-tabba@google.com
>
> diff --git tools/testing/selftests/kvm/lib/kvm_util.c tools/testing/selftests/kvm/lib/kvm_util.c
> index 2a76eca7029d..2476167252a1 100644
> --- tools/testing/selftests/kvm/lib/kvm_util.c
> +++ tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -737,6 +737,12 @@ userspace_mem_region_find(struct kvm_vm *vm, u64 start, u64 end)
>         return NULL;
>  }
>
> +static void kvm_free_fd(int *fd)

Not where the line is drawn between "free" vs "release" in the
selftests, just wanted to draw your attention to the two terms we can
pick the correct term.

> +{
> +       kvm_close(*fd);
> +       *fd = -1;
> +}
> +
>
> [...snip...]
>
