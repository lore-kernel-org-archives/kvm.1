Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9133DAAD4
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956673; cv=none; b=rKsk9HUludP7zn0dTLd4eZUxmURgnYNF5Ai9edc9DDNUNZPNwAwPJAuSS6TQtFSaOIC3oO47s4z2Bg4sXK4G3r+sRTroG77/KQ8iM+d4yFHoUOR72lG1Q/GLH/iTVPljgQEMQh2gs3KqvnW1l1PJKdk5QKlolvICNv6Kce9S0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956673; c=relaxed/simple;
	bh=cHTJQT/RBVKmLBGY8jEZzpAPKstx7GoblZ2qvVZvaPk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=gUjmDaZFB77Q7PUaz1FnlQEoWR89HVvJF3gfjfEeHMKKvrPNKEk5xK+RNxwo8Okwsx9nbfa8WZh+ej3GJ+x/xTNND/F6BLva6uRweuL/vtYou0clT1r2e2I14O4nnruiFB34R+P3a+vr2RYzH+LHOsyfCRjMjlZkvEezrbNo3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoCQUYah; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoCQUYah"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe3fed2f58so1133663a12.3
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785956669; x=1786561469; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V5Nj3gKC4yEN6e3D1EtvSjC4Has3vClSVMr6RcOyF2w=;
        b=CoCQUYahxJaR1S7hhSRrAFui2LryVSJqbPV+GSjVS0HCJl/B60TxQ4kKasB3XckfH1
         CzSeHKIWy+1LS9p+JPflidlb7iG/yX3f392aSX2Fa+qQED00IdUzxKXwGaqr8W1t2I9h
         0SfrhS1LCptm/4IdK9I6bd5XWlXhPCWMOeUd/GLYL7Lq+8W4XGY+suweD1YfRx613lq6
         4jKJ2YKKUJduNnK07kGOovESYfagvbLXQL15l/75akhpBd1CUjsjAXXj0ftMqVqoPvpZ
         mnK2AcjkfgDyZ12cpada6aM9OH2GRpjCrum2mT+8UFcbRfQbe04xbBaO9EQz1wDJyalr
         mfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956669; x=1786561469;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5Nj3gKC4yEN6e3D1EtvSjC4Has3vClSVMr6RcOyF2w=;
        b=JSEC4x6qrl9wRnBw4MTKWupSKGqrE0LmRNLcigja+Ml0Ao41XBifBs21MOU8dhH9GF
         aO2k7gPT5B1mupIDV+P8xBB8dCZnjKh1p3RMY1sbY3C4rIJfk1+S7chVXxIkwC1+vR3S
         JH+55sqdyxm/DItwNrXucpp/SCwfxGIJ1ZNLWTm76UoyU04BQvhQEa2bUAzujkhk0HYs
         wfQ2BTaxJvLHeXpNI9muMkfusSWBeCDQ6QLVLzEHREYqL/fFKJZwXx0SwvAPTIm+7qU9
         tzSx3+wglvclD0JWrug2NFTO+YgzHWsrfU4on/m+ZKNWh/UM7wR68qPbg+H4/oRgScJF
         w7iA==
X-Forwarded-Encrypted: i=1; AHgh+RrNRBe+IyyIsvUVJqilLGOj9Rfqzc9a3z14smNvtg5EG1CsyZvGFk9A5KxrolSe+U203fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPAZw8UsOXQzVkyZFMFAT5302MqElfFs9PL9L+EUAstPydZkl
	Sgg8oTWjFhPZM8H4sotOLdMtjrh7tBDvYa0vjckRNSsWpTIBIoisJe/D
X-Gm-Gg: AR+sD13H4lrJAMyh2HAOqdoPw0WnvgFogA5HXI5Xa055EtebKiiplUqACWaNSsF7Cas
	0/BCjUxBGrlpQ9T3JfV1aWbPX6T9wl4vIGiu1qoju6zxKQhIQtqwwTvZxfehbxUYqa9cZlI+X92
	eFu5j1OEm+Lp9bOl7hSiVFv3KYpU5RahYwe1dfcJ5ojxJX2pOzYQ2Bv/a8ZxdFdmz0d4YB9cYCC
	t3ow8XbKFU7tjxnPGvkwEvb7JDuX+ykf0FiF1tL7+4mIQjjjx4ID68jMvinnDk/RdKoJ5SkI1GW
	vfOaOamEkPCL+KbxR4MwjZd+iN3ozhgUOdNyJVCRfTVDDiwzfrNlIsj+HOZI2J4gTqG0aP4aIuK
	ZWjTKoV/TsgIQEciuQBU4Nk75vVsDV1oIsxcuuJoNlHwvSunTu9rD3lC2qa3AjDM8rYW5fV93Kl
	SE2lQzVHEVH3YBKf3RzlvauKuNydqV26zsgtfA95D/EF2ASUymbeCnAgdZl9k=
X-Received: by 2002:a05:6a20:918e:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3cb85e2acc2mr8616548637.9.1785956669049;
        Wed, 05 Aug 2026 12:04:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm31787485eec.25.2026.08.05.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 12:04:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
In-Reply-To: <20260804180705.59160-1-amachhiw@linux.ibm.com>
Date: Thu, 06 Aug 2026 00:09:43 +0530
Message-ID: <tsp8l8cw.ritesh.list@gmail.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>


Hi Amit,

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On POWER systems, newer processor generations can operate in compatibility
> modes corresponding to earlier generations (e.g., a Power11 system running
> in Power10 compatibility mode). In such cases, the effective CPU level
> exposed to guests differs from the physical processor generation.
>
> This creates a problem for nested virtualization. When booting a nested KVM
> guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
> userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
> and attempt to configure the nested guest accordingly. However, the L1
> partition is constrained by the compatibility level negotiated with the
> hypervisor (L0), and requests exceeding that level are rejected, leading to
> guest boot failures such as:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>
> This series provides a mechanism for userspace to query the effective CPU
> compatibility modes supported by the host, so it can select an appropriate
> CPU model for nested guests.
>
> To achieve this, the series introduces a new KVM capability and ioctl
> (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> compatibility modes supported by the host.
>

Sorry, but I am somehow not convinced on whether we need all of this
machinary just to get these 3 bits of information, which we are
returning today.

Since KVM_CHECK_EXTENSION can already return an int, so why can't we use
KVM_CAP_PPC_COMPAT_CAPS itself and return the bitmap of supported compat
modes to the user?
Say if the cap is not supported, we can return 0, otherwise we can
return the bitmap of supported compat modes. This will easily allow us
to use 31-bits which as I see would be hardly a problem in the near
future. In the future if it grows - we can always use KVM_CAP_PPC_COMPAT_CAPS2.

This should reduce the code complexity both in the kernel and
userspace and we don't even need a new ioctl then.

Thoughts?

-ritesh

