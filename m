Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361D3BE15F
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867445; cv=pass; b=npzRwVX4bjel1D4JKRJBXcvhSlL8l/AmaWAr7nLKIRV5LPzbuH98pa4YcL17UAv5+vIrpnyvRtPlMtDgvTHHZe39kmlDeOOwGwm20qXd0+gueqLe16zOq38dEI27LJ8TZkoSueCAHumYZ2+U4jqEQtxoxAtqrlmZ3fDWQ2dQ4K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867445; c=relaxed/simple;
	bh=MNYsSTle4ykHWFR3wA3fpHiatEBn9otzPzItArcI/oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKGHxV5zy2I1fjNwAzHdQoHm4bByXA20ZbbUIw0fKtXX1bHgiY+Z++vtqKQll7Jk67e4cKSB76MFDW0rnEyOpFJlwB4Nivnawbyj4JzCFkpdMb4eNR/ZdMWT/PZKoTWcxmmNSUo14Rcd2tck6OPCBlXgggrGYvTbgS9qVVK3AWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATtYycXh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=exlQpbp6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATtYycXh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="exlQpbp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774867443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/V4se3IUsSn8zO1nINDd1aBamalJz9syleDsNWynbMc=;
	b=ATtYycXhqD8wsyI+9nc95gPhXBG3l/+dPv455w+2WnwNeOrlTBoFrp0wTaqsv3U8lkgxLU
	2xH2Qtbm4GPSheM5+YL7eVhfi4hLo2EEf0UynkGeRW/Hu9dLX9s2dScDtP3/CeLot+AQ8k
	EruMvjk+GvHxMKek/FA/DITlh8c3c5o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-3_idZqnVNA-eAU_anVys1w-1; Mon, 30 Mar 2026 06:44:01 -0400
X-MC-Unique: 3_idZqnVNA-eAU_anVys1w-1
X-Mimecast-MFC-AGG-ID: 3_idZqnVNA-eAU_anVys1w_1774867441
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa35b005so53837285e9.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 03:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774867440; cv=none;
        d=google.com; s=arc-20240605;
        b=ZwEUdO3ikPZoSUf6XuJAjvKdUem5q7IgjPGgbFD+mjjS5wAHFQ/aqufTEWDjddVzlV
         SD64Fb5hxExlgP0WTDvD+IfRnubJ+YiVvOf5105oxhC1GLzGJOvvYTcIh79Y2HsJdQM7
         jL32f7EVoMAnZMfXZyAgOjWOwyyz5Y9fzh8QrllEJSi6+yt9KMOR3mlfinqI2y5kWibs
         qqpFhpzupd7vnAMuCt/HoD8LlB0vYOmABcWZgB5B4tAfAwMU5JIX260C8dTZ+r5JPU7D
         U60E5lE4IKOCgwbhlRdU1SZXV4egFBxPcoLlgsY2Ql495+x6j8TUdjjMWbvkBiwXJ7j9
         2ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/V4se3IUsSn8zO1nINDd1aBamalJz9syleDsNWynbMc=;
        fh=Yub890fqw3Fkp95DLCe44Z+m8aIOyHEuFuU4mAHfdzc=;
        b=eJOHCALFJzIBuUj6R1kezUsjscXk9b+8nyPAwbSxtcc/h+7QwD0s4B8ldQsJLXC0QX
         /+vpE/Uvut0xgsNbDhgauBYNQacTc42ikvCN0H/F0NseZkIx7j3GcWh+5OFUFxJQcNR6
         XuPrZ9e5+n+4gMNh9RzYQWbtZlN3jUsZKhCnXJ/H7LVa2ZRMTwAPAiOn6poZ+8qKEW88
         CCt51XjulIl580e09aE3j+EP0WcRsDamZthO5+pDHOlP9paYqmFVD1wrI3kXxXR7ZrMV
         V6xLqKIghh5qKABLKcNtgZ04n73a1PO++XDfJl0nkFNKq6s5/HPPkm56yA2bunjebYE7
         anxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774867440; x=1775472240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V4se3IUsSn8zO1nINDd1aBamalJz9syleDsNWynbMc=;
        b=exlQpbp6IIfaXWftsPgI0Bncu/RS73g/CR50erXHZ1tTDODEdxRUdBG6gLuabvICp5
         eYcezd0c4iu6A0BY+v9dOM2verXxQbIgZaxBeQLXLm9KEw8QQ+YN88RR7T/ZKEtSTXbp
         Czr+OZfV0u8pXx1jjAzOaX4iyJ3Du7bgPt3pPOG472tWy6kY6vdDKs/NKo4btFn7IeOU
         IcxNNICzoCriGqFKq9u4auEAt5Mn2IZMx+rCblB5J0YqkHmCaXHyyJ7aXx0VTc7z2ECG
         g+RO00jLgZdusvi5m0eH2uMvz4wv4CGSunA0pzq/Fi5chWt1aUY4Op4taDscxR5/AuvU
         PbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774867440; x=1775472240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/V4se3IUsSn8zO1nINDd1aBamalJz9syleDsNWynbMc=;
        b=Kb6EEalaWCZV4X+LxMyGA61wIKtpkBtb/Na9oS/jxxXG1Q3lbWuJKHdHqXjozDr5qT
         05FvRCzajzbX+v4TX00Jw2SUeuzDMwsyqsIBa6wZ2donHAxkH/P2/SbRUE1df2/ZtUZp
         7KnBedu/534V8kY/9wJX5R4BBhqSE/CEN73hOFc9Gu60zXIs9XtikfNhIuy2boCaYv5Y
         9o1Tm7M40CyngDYq3XaQoyQu6VBQyS8wHIzqIIMF8mlnYUbeeyPnb84/iLqBTVbkM1tA
         OoZayp0L7BPAWenbKjIsKZIV3Zh4e0vPTTjv0Bg3Cj3QluI5v/TQ2KKyFCePax+Ac7/z
         /rGg==
X-Forwarded-Encrypted: i=1; AJvYcCXXWCQHiDgCCZD2VfMPOh/ah4QSUuZSsBeUdxRZb92csoMV9OyBEzUqlniHm0JSHR6gde8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY3ySriq2I9nXKI9DmrSv7JcJHr3cTlb8fzZt1Rqg217G6h39H
	nuMaU3mTgMkGywZb1Salat3p58qJq1KDEdTtBDMSG5upYcHDY5+xMGtys70rtpvptvj+nfQWKeu
	Es5NGhZijmeztt2T+3RFw5zZPSgBR83Pii8aJcV3Hd8wM8F0c7h25kmfxOqZfSBrniV4egT3fGS
	PhccL0jg+B7cFOVEs0waiOuVETdTLL
X-Gm-Gg: ATEYQzyohku0vdk7SN8jUYuwEX/7RnGuhaaY9Rhc9oaR+cH7MsaYolpJyur1O3ljhmf
	GjFNY0WiAd1YsOF2XNM68pU90alpRtz4z971ntq8tOt7lWnVdnHo6EVklv/I5JVOtGOZXiwK0+y
	kxzPNkpPQF/mqll7HQ0+U6whiW6+xQ95Gk8wL6VQ2WbblBYZeJPI+4MiZiOOQcFtimXlmMHhGwr
	1xJmUHQwMPPnBOH1+VZ2ZQN1caecT6dhi88AD5L2BZtZ/xDNN5bID4Tq40qbBx+sUdq4exAvdun
	q/Gc
X-Received: by 2002:a05:600c:3d87:b0:486:5f71:5829 with SMTP id 5b1f17b1804b1-48727d5a307mr197440435e9.5.1774867440490;
        Mon, 30 Mar 2026 03:44:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3d87:b0:486:5f71:5829 with SMTP id
 5b1f17b1804b1-48727d5a307mr197440155e9.5.1774867440021; Mon, 30 Mar 2026
 03:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326181723.218115-1-pbonzini@redhat.com> <BD696E74-1EFB-4E70-9DC8-756A7810599C@nutanix.com>
In-Reply-To: <BD696E74-1EFB-4E70-9DC8-756A7810599C@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Mar 2026 12:43:48 +0200
X-Gm-Features: AQROBzA6aQ5DY2MA8VIrtwkpWOmGdN9dkOimoQ-pdCJfbMBrcq5WVyP1Yq1Xfcs
Message-ID: <CABgObfYhNJhvVhe1nRG11MMF9p=eT-QoaGNGaN8P+YaywNUg+w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/24] KVM: combined patchset for MBEC/GMET support
To: Jon Kohler <jon@nutanix.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Nikunj A Dadhania <nikunj@amd.com>, 
	"amit.shah@amd.com" <amit.shah@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 4:28=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
> For this RFCv2 series:
> Tested-By: Jon Kohler <jon@nutanix.com>

Great, thanks! FWIW I found a small hole (just by code inspection);
translate_nested_gpa is always setting PFERR_USER_MASK and therefore
always using XU (and always allowing execution for GMET). The fix is
not hard, basically translate_nested_gpa needs to become an entry in
the nested_ops and the callers need a little bit of adjustment to pass
more info down. Then the vendor code can do respectively:

    /*
     * MBEC differentiates based on the effective U/S bit of
     * the guest page tables; not the processor CPL.
     */
    access &=3D ~PFERR_USER_MASK;
    if ((pte_access & ACC_USER_MASK)
        && (access & PFERR_GUEST_FINAL_MASK))
        access |=3D PFERR_USER_MASK;

and

    /* Non-GMET walks are always user-walks */
    if (!(svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE))
        access |=3D PFERR_USER_MASK;

I'll post this after the series gets more review altogether.

> On the ecosystem enablement side, qemu has both mbec [1] and gmet [2];
> however, they are not exposed via any model definitions (yet), so users
> would need to manually enable them in the short term. I'll work up
> a patch to expose these via model definitions and propose that to the
> list this week.
>
> [1] https://github.com/qemu/qemu/commit/bfff4b2ae5452463ab8c14b4a8a020288=
b5ff5d8
> [2] https://github.com/qemu/qemu/commit/746a823a17f25393cc8c0cd1257f6dcef=
757bc09

Sounds good!

Paolo

