Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941288;
	b=dDaVDfwBTupqFc30Bhl5o71d48yrDZhxKF+KBGHqFGxL1SV7lkabq8+Q6SSw9bERTs7T
	 yJu5jBj+fm48Q2U/M9LEEEbdobYFb3zM+fI7GOcq7kdsCMZcvOepbWlkHyemD872aIaba
	 TQS1Iq1vx1Y/s5gCylnY/eh2/gTAtH8o/dsOpfxhRnxQUIXgsZvR6Yn9THalz5jMQpP3T
	 WUBvs5N8E53jKAdeD3m4LQnWqKB5a0L96TanzNZILZilssm90fkLyhRpblVHEWxUuJfBQ
	 +83v5Hi/FQaGj98zm3dmdsBaqFeA0ciMTS2UaWB/SeRMfncLQ/V7WUeAwd/yBnIeryg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xtLYzvB4QwyE4CQQZBVQ03agWEuN54VOUX3M+RpRBBA=;
	b=h2jyxqsnHkbvO+iV6CeAEFan8h8l7MjGWRH/DzDc0YUjlpeF0WhHausQ+ZU1XQSpRaV0
	 Ea0bWTblmNOM3+1SrhtDz51i1PNU94iDGnQl9wqNlwJaM9QBW4OTkx5Xw0tfPz19z+D4e
	 RyJpdcbt3C5I1856kTqMHScqEjwSXgHzurFo+Ek9WBEitTSPPhUPZvDDl2/Qva6uEiUFV
	 6TmSEAIMCeZhzH6/UBCDHOPmTBHndSP/FdJZoS6QnbBwLtb4ITqnDG3nSOSDWZ2cHyA/l
	 1k7Q6ts+iqsolZPBlXm6pUgBSBsTQvlM4YntjGy6SHg8MpUAU6iwqyjq5hIlnfGy+Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JetxdjpN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC3606A31B
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54BC3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JetxdjpN
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-54492d8a988so51731cf.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 21:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793941287; cv=none;
        d=google.com; s=arc-20260327;
        b=VDJ6bqDptH5Vkdf44NCBfpQsLc5GLPL2sZrfozbHjwv/2DHJjQ5YxQ8fhDiuuB8rnN
         ptuDPDMoB1+k8VrXTQb3GII5j0M5EdkCzU7u57wvluYXJ9pqbxz2mrCWuoCdjLpvUh3s
         Th+krViXch5hXDYZzeBMnMasuTIiP1a2mFPEv3wVm65NIFaBO8QuGfXu2pGaxAxtW75l
         98x0z5XJmnzS9KxxecfJMVskddd8X315Tb2wVAdsdgJOxrrQDk5n96nw5tt+YwlRDfBE
         m3cTJNZnNgMBNf5NA3NhVkbrjAIBf2E7lwtC8P4uPkmh7mj+hy6BypegZf8+zC6iBSYE
         mtoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xtLYzvB4QwyE4CQQZBVQ03agWEuN54VOUX3M+RpRBBA=;
        fh=Wd2XnyJvzxFUbwxVcUux2EGZV21s3UmN/kWC+lZOsdQ=;
        b=DqwIUQVullESZhxXLGrDcroIfPIVm5ICMppdkJ22XM/yiMh/o4SeIT+EUJbwQppf9N
         VjHh+WeMKSgV00gQKF6Iy1PAHWsdMPMmhAjhWFhpkf2BkLMTf0KN3OZYPbw1AM8IMj+B
         vvXxSteuMNiyQeAUQAaYBD2H2Iobfu2Qv2revl9Ji7GdGCKIrCkGkQMErsITXMFjji9E
         YWIFRo61rJAhTZFJdLrqjELnYdN8JNocUhF7obv8gBfX2hgK4AxDkGrnWfSq1sbjBDf/
         PT0Moq8EaDvLWQiIerEd195QLKkv+v6AIK7LVLCOALUWGROGnds2V4LjAaepcG3Ahokx
         IORw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793941287; x=1794546087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xtLYzvB4QwyE4CQQZBVQ03agWEuN54VOUX3M+RpRBBA=;
        b=JetxdjpNy04qLWgZ2MgoRuiFvxEV51HgOqbtf7EMMncLAaq+SM2kbVWZethMJmbGq8
         hJ829usL/kMbPBbHSdG4OeW4jLnU7gLSsCteTt61KtGEItKyTqm4CzGmiZvoSU9vjti7
         H690meOzJs2mlQ6Bho9bVL209h4h2oJo3XGDPJdYqwusfue7laXufhBIvuN33Yi6Ck+e
         oaPzgQK/eiO70nTmrxqkg4bCNW8r3HF61N+IqCPNjnEoqe291qHZxQRXGaJzVpsErD/t
         9+BRG9xNz1btvq1P2T/TQAqUe8hSdegSsVulMtVP3YG6tcVlStl0pNxxiQRob6LSIJ5f
         9gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793941287; x=1794546087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtLYzvB4QwyE4CQQZBVQ03agWEuN54VOUX3M+RpRBBA=;
        b=e97bsF9RBTBcPbK0F0rCm0dbnXPRUAtB6u14RPCLZ2egXBeCtQc+I6GUBNiLrgRwX0
         j9LqCreuQqaNCBZav7fzqJJLUXy0CCpGdSlqG1NrjWTLLHz5936kYsXtalYeOgLsqEYR
         si++uot5WM5ucrVL3b3feDCeVt71BeXykJ6DRTUucq552HHrtmw0yWScg73XCV9g+Q0/
         1PILcBPZOt8aXofCx41fUV/bfpS84GRw6UubsNqZT+qFkG0wx4SlNjHugTJM9eqYWI9u
         Bz2Nu50MqhcnOXgUjihAEW/Ccth7O/6izOC31MXk5Mxdr1P3L/91gI3m+rqUWtrdsb64
         ruoA==
X-Forwarded-Encrypted: i=1; AKwUvBzWAThwUHUxX3/NdiE7gPdhfravZ1OioG4ILyr3BeHVkpi8obV0QdOhQCrnBOFapHffMF8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WXfOcw5WLOxnu7wK5uytnT4fWIi0/kT0GQ7O3Ul2RqsTFIqy4
	E5u+9KSKDHZBXinlDi9qe3Qcau+5twOaEQkusRil5GGNAvbUNeQJmhso+L5aY6Ty+MZBsQQpONi
	Tb6928m6pIZNyrYDBKEubkX9nkDDVHxKW8yKdVr9+
X-Gm-Gg: AYBFou3NiS2Lz+2cyMnbUZJmPdYjCg+h4G1kU85jBGEjCNQX2NTIaLS0SmGyDMjfXDH
	LmOiaP50voq4N5hLZKcjB79kHyNskdsRgnMw/wSAppVbYCjmR8A5Rn8Cyz2tlF4oiYkOeTsG6/s
	KYyaoA/Pwo9Mpn8xz9OLO/oKjTfP+uCIoteYvnp8a39QjR3jcDty+SgEoOM/T1IKK/dMG+pK3tr
	Ti7E67MLJq5QjI3qFJk2b+YqhOVk33p882USRms9VT2owe5sNVVaT0HDtwXpPUOyOBiEktJWXIz
	dmuiGD1WdOfYtE74Id+hgsA47iMM7fnHSLwnDOlIQLB1Er70xwMx2wSmtoDjL5KYkASiSAVb5eJ
	YpNh4xqMTq4/ftEPoQUj3cgH+CTjRA6j+Q7+hZ0Bc+DI/2kF8DB7VRx8mVHf9tyN4+kR6tEGFIS
	5dBLzTu0xcOlFU1Orf/iIDkq16
X-Received: by 2002:a05:622a:250c:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-54eb746fba5mr594091cf.14.1793941286561; Thu, 05 Nov 2026
 21:01:26 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-17-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-17-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 21:01:09 -0800
X-Gm-Features: AclHuK-ctdXjo8QN3yQuitGR3bekhHL6BOFHnzufPuigJe6OXqS1fnnmKMIqztE
Message-ID: <CALMp9eSp7Xj-z-8Wj=XA+KEk1XKTWpvwygWpdgzKeKQmDCobVQ@mail.gmail.com>
Subject: Re: [PATCH v8 16/20] KVM: x86: Add APX to supported XCR0
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:07=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Set kvm_caps.supported_xcr0[APX] when the host has enabled the APX state
> along with CONFIG_KVM_APX=3Dy.
>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
