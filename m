Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98692D7817
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680873; cv=pass; b=to6+w4SL2HMoggG9ssso+U/55QGvEKanWGXdKRxLR+F3QymRk36GblGeY/I8nOuKGbuPdK+n1/BasFwMfD8Xq/pLAoerPRCBet086N5+vXxpewv+taq3BC3g4kS5RAv+ScEWxnj8wkzlGuE997zjAqorbeZozg62d5YEJSBnjtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680873; c=relaxed/simple;
	bh=RD4OGmkPPwDJr28WiBcDOKbzVncRVUnT9eJND+VcFJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ab+nJBQlzBk0wpx9qecepQcXrU8IoxfIY0KwsRmdPrOBjpV8/rjbZYMbyPQi+F9SVxXjf8+6Fg48cbzOeHavOwwjltm5mJlzmoSclxt8OVLEdwEZD3f6/MYkuVRsIpIIfz3/DT8VLd83miWAmfEDN/oxmSSNRrKYbEgU5Mubj2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXZ2yRoN; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXZ2yRoN"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so57662a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784680870; cv=none;
        d=google.com; s=arc-20260327;
        b=JIyP9OxSKfwPqKdAV2eHr67zKwu12ONRfrLpHwuEnVbY/YilM8Ag0F932fGW3Eqq3q
         IV5/s5QStYSpnNpGTVKwfmfSDzrqb5kbC59XBf1kkgzjUUwBu8McOpmryZuBOkoYJsOo
         AH+OYJ5PpT9exHcnSu9H9j4hAOVNpnUvrKh3/DGVnnO+0KcMQKXDWaHuxZRJ3Di5c/cK
         +DvBGA3auPiAWHjUJijV/0hSE7E8D4QPXa2Jq4sUTOTTXgDPQ/Ton2m9qRuSwqMmnwfW
         Cwahed891f2+s/XGtjYOSvaJ6XLYyKG9kUK+TAthuwBBS7/OjpSXAVydzHI+w0HgzWdk
         5+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NB37xNMH0BsWi/AevYyT6J4s9Oz8TaSpTpYzFsxqYcg=;
        fh=QIWhhjbcG63n2zONOcHBIo+b6zMXvOkXig4sFNFzvjk=;
        b=n48fW2oS8DZylc7ZMvJCaCtcLz9JuMGHOucydxhwAbj8bhkcruzczlGB/YXMrFPOh6
         cJCdBBjZ1wJmp7PVEMm752CxMmux5Cz9r3sq+1RREMijCX/ug398/vvrMELS9LoUbU9J
         XGb4x40qGGPaUaIbp006xNtV0eZ22rPQNRI7cvr9kQEiCTx5lUIeNvs1ieXATnTiZhv6
         5cXg6cdjx0VbWoyEeKnf/m4I1SRKF3xc/PO6mHQ8cutnYGQVVf0MDMrzfMnEfB4sdSJX
         U+/G/7JCWMlTAon7EO07JM1/ppmS44dQStHXu3bBnt7OgSXaLYSzIPG6M78kn5GlrLbk
         /NEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784680870; x=1785285670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NB37xNMH0BsWi/AevYyT6J4s9Oz8TaSpTpYzFsxqYcg=;
        b=qXZ2yRoNWZQhBZepxsZxm9D5S+wrbXdMLtTkNR+5NBhCjJd8iLl7Q4zrsjLPy1D+Kw
         kul3LucRyDw+36D5nP/QfOl8Cuz8lfz+C7LBu9tX2C9z5bPKAgg6E7Xbg1r/DJ0qTokE
         NklVTgLO5wEGgz5yXqNHef8Y6anyXBy4ofWB4auN5l9eIlcO5gL3JrCT/gp0luWhNqDy
         AnLjmZWashuK/4uyQncMnaADQ1LTD5h0ia8r9A0YVykhIpEV6os81E8z0EY3n7l45oI5
         K9luUXeCEXn5k1eSC2bGOJTQ3956Ws292bsA5OVMGtFxodiJVT+vzvyYh1XC0p564luE
         LOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784680870; x=1785285670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NB37xNMH0BsWi/AevYyT6J4s9Oz8TaSpTpYzFsxqYcg=;
        b=XeR3iObJuSNcRZLidYrF1ugVpB8imSR1vu8TpU2SUTbRO2FeA97PRv3pY0Wcm/yaR3
         1kuOUe40DWAlYVSdKX5KDb1Zor9Yt/K/edeHSM0UTLvJXiwRwyuncCVKJlJlxt+vwAeX
         Pja1HkgWxJCR01gUZJIA4RkXgWEt0lfn67KgPNPKNhbicHiypVdrMeJKXnltN+XJt+sT
         siMaxgcepFaJlJNMcHMJ2Z65Jo71CdajFkL7GO8f9PDToCRDj8o+7K1AD0RfjL9stzmR
         ux/9U2X/gc47yZACZFWHDlTDL+tmtDOpOJ9dlTFoPeUbM/ooWHFZg+vWLMZd/sIhImva
         4iOg==
X-Forwarded-Encrypted: i=1; AHgh+RrNbxHK3wAF0v2FBUULWKtAQXXB8cv8fqIYJiwyr70H5COHLuwARwr1uOBMrB/iLqRp/RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOczSCae4pMkWVj2MM7+j3Uy3Vn++KyCx12ARujm5kREb9mUoN
	kT2XP0rz3tAI9fGgHrjh7EIGPSvsPYZrYrwINOeSMvB+hnfrhf3+QCsRmUj1ixKVdvaLLbFoFTT
	AYXvJYIHJ4jvOfozCgJ1vxuJH+um/wcr8CRxBNBgY
X-Gm-Gg: AR+sD13osWYKwnMvE5LmmQLfxDokHLH78G3GXZlrb7Q30+OdBJUPVwt8BPrWrFcLZHm
	VWs8fJcWljlkqI396ca3fhUVf7H1gLBdG04kVl7TgfyGAqwCMK3/P7VwLmRpmcuHAtYJAdtgdnj
	EZTlTT1Z1pRBOu9a08dDS2zw6H/EVXVUvMYHUtQQqcgqf1xbxhRa674y8ITByoprxJd9OX2od8y
	gWbyfPKUH+r+GrL2r2yqMi/GkWsiFo4+tK0b+e63m2E55lek3wdiJEZeQ5+1Hs96ns2KQnC
X-Received: by 2002:aa7:d387:0:b0:697:9254:a66b with SMTP id
 4fb4d7f45d1cf-69f35fd5e9emr26498a12.6.1784680869728; Tue, 21 Jul 2026
 17:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720231639.1592848-1-jmattson@google.com> <al9cWDWvIK6RCrnN@intel.com>
 <CALMp9eQN_UDhd7RVP8v4wBTaEbq0GXmbAiay+uXgzSEV7T1uQw@mail.gmail.com> <amAQamArzJOaZwEL@google.com>
In-Reply-To: <amAQamArzJOaZwEL@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Jul 2026 17:40:56 -0700
X-Gm-Features: AUfX_mzGYpFdpgYOaqOyVZKifjBgeOJZKSv0gWkOMEs60w6qf-rLgnF5QnELKU8
Message-ID: <CALMp9eT5-ozFChQwYqVkzuNDyC_0KDar+RGvirPkSyTjqb0rsQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: VMX: Cap VMX preemption timer to work around
 Intel errata
To: Sean Christopherson <seanjc@google.com>
Cc: Chao Gao <chao.gao@intel.com>, pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:35=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> I vote to go in the opposite direction, and double down on the code being=
 64-bit
> only.  If we do that, then the annoying 32-bit issues Sashiko keeps point=
ing out
> should naturally go away.

Oh, bummer. I thought by "the code," you meant KVM!
