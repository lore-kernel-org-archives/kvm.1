Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB3233923
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186496; cv=pass; b=iPoExJoMxHBdv++ukrAMUmEKp6tYy/u59OV94A3yNfEohd8OSwMMPW7H0VrW177nnJk7uScgGNKpM4dwxU6CcXStKZWpceMr//F3qc3OXhyC/kzrfA+rDrsZEUfZgdKx9KRd3B8HVUMivrWEIo/ZQmfCnZpDQxxgEf9pG5uFeV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186496; c=relaxed/simple;
	bh=r6CVxkmW7gPEuhjbWFOBWd14er8fl+0Pi+qNc0Kinb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFVH6Qqgis+Yc3IW+1J3nKPs1BcCfwp93e7PR9JLQsiXkc8mZykHP6alQ9Q+zhAWs1UeYJgnfYwJbii/EAol4imG53JpVCIsaR/5eHH6kxOmGdh6++bcr7LWg3hnixjmlHwurqpN1+54kRdQ09iPc3w+XfRHZnRjaM/S/4w6skQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqnH/JAF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l+n81K8r; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqnH/JAF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l+n81K8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6CVxkmW7gPEuhjbWFOBWd14er8fl+0Pi+qNc0Kinb8=;
	b=gqnH/JAFwCljRqQiw99s3hBN6ehIoJrzPB+yz1hPh7WfdTEmvKGXo6B5DLk4Rkv2Qveu4v
	SE4+4YSAS24qWKEdWlzYl6Z9LrZnO6rN6qNSeIlS8xtSz6yU9Gh9+fBftAReDjQBGyUvg8
	sU7S6dFFX5s57SdmnPLHoKPHw+kZAcQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-ZqkyhzyTOvOCV1UaSa9kUw-1; Tue, 19 May 2026 06:28:12 -0400
X-MC-Unique: ZqkyhzyTOvOCV1UaSa9kUw-1
X-Mimecast-MFC-AGG-ID: ZqkyhzyTOvOCV1UaSa9kUw_1779186491
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44f1b4d0fb0so1985172f8f.1
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 03:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779186491; cv=none;
        d=google.com; s=arc-20240605;
        b=lx9WwfDaw1AwKJC6XkzF0U8j/O+j0TZHiay/LcptszZIT450NGbE2uGuRnyOVz/ATE
         axZPU/ajHBn+gC6MQPnkkQyohnCtHQ262E83pQEiDXSbEtyJB8zCt8icCOciFgUNkRHy
         oaSX5dzPK+hzpMpR45aChbCCHNgaVLz5UDq5sWji/P4IkQ7NAgYqvE8P7i5E/72MR18Z
         ze4ftUnBB/K5GtzCmNAgky2zYMa7utHCIpktFUXzBFFHdztqlEKVNQSBFraqpw0XHpW0
         d6qcuayJGEM0Qf37kSIV7VX4Oj+Ulw726J+eQMgUAsb4upWLSXowrT8UnQb3zJBspN9a
         Xcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r6CVxkmW7gPEuhjbWFOBWd14er8fl+0Pi+qNc0Kinb8=;
        fh=IUv9OdFYwlJyf2SG0c1JQUY4mI+s683co2aBRw519PQ=;
        b=j1QLElwvRQ6Cocp0COy2mruP33dJGmFK46430eOeSA0e+rVCFs0vO1sfScRZti+ywz
         KWMFngTtpZfMlzkmEnfFUK5+s4Q6JrCEGQO+pfnYS7251LCHAZZT2BZKdxGlY1zW8DjT
         f3g2S45M9DGpFHVBI3JI9QbiJx83DZ+M8acnOFax5yTaZ16TMxSotGQ8UPVNRCkFO6H3
         q4QD7cw+iKXoTl8o0yWuwacNylYsu57cFukrzRhoaBcwzPJN3RpMDJDUyRo9iBEPHgiC
         FHXsg0BXGS2Us7indoXv7bdElDupgg8PPzdU273wPViM6PObNmX76KAR/3Y8J2HsBtjv
         OZhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779186491; x=1779791291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6CVxkmW7gPEuhjbWFOBWd14er8fl+0Pi+qNc0Kinb8=;
        b=l+n81K8rAaB4HUzfc/yRdOeCQSxCeXJXAg56Sg9KyhNHn2hPdCC5jDNThFedGCcQA6
         bX7h5EQ1fC1+0Ie/Jqxvbc8tXm165EHLfQ1IHx3b1UCs+C34eIAQT3ZsiA1vo7N+MrGj
         dwjHVJAoDbm+PHM5coFV1w8UQ+Wzfd+K80s+N9OkHnWWJx4hvrSMLjMHoPDt4AOmam6p
         I3lTtjxcoB+ftm1FvVR/SR7V32//5561GEDXDsm32PcuRnO3YiW0xUX0QCjVl608KsUL
         hd3y4nWFCgzN49pZSfylctTqzOZRCWZnJHDDMTsnXOcdxwjpcSCRrC+tZ/Lg1ebriqfY
         YA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186491; x=1779791291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r6CVxkmW7gPEuhjbWFOBWd14er8fl+0Pi+qNc0Kinb8=;
        b=FgonFhnu+4Jw8tsMzUGOMvSzsTLQfymwmGkXIDDTQHmV9U3VTgl+AZm5nkwAIOyboI
         LpEns5E0ARBkKYzsq9QY68l/3B8anmq5mDN7BHv1DmoPMEz9TWLzCCeVDDE+da33fem+
         0y9I+EW6vcLCZtiU2qV32sZwnE1IIlWYx+2a5GrvtZO8VwKw+CvhzeRinZvtQ/9yn3yh
         +pAtDPHNXsZ5zr2lnqeJYLuMTgYbTejZAk60eelP+kzO7VD/hp8u+5ZtMlUNsCt8pVH4
         ey2mYbDkkwxeaOCWAg3yvTZyMNvLPge0tcHbIEsIgpK0vi+wrFu3N3MyDQR6EjCnMWJo
         t0xw==
X-Forwarded-Encrypted: i=1; AFNElJ/3RZLh9FuaSkdjjVPFmsm75qpBotCDaxha1Fv+4+R3HUembc/rcP9fuTFcuyKnJX3UYLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYJP843vEmoq1H9cPZ4VGCY968CaqXenO8kGvZH7yKOc5GoJ8
	FTj/z+0GsMYuW9eGQu2Prb5FYFQ5Zi5Qv1D8oZ7edug+n98MCN/kJ+8ivfXRfxgJaH2n+CBZYnT
	7RexJ12jXnvZVeKk7WNSuAfLMZgGD/0XM2N1Kkiyrk4bMM4Q1jn8e0Q7ChCRw5E7YgP7l4Ni+Ht
	SZexT0PzqYfhis/Tqyvcd4aPZzPjL4
X-Gm-Gg: Acq92OEBM8tCctpTiz3y1SsZmr/bz0vBiQurGEeG7WNYeJws5APPjG01sjPjaGAvNzL
	GuPIz7GoR1eS1zvfjSbR9VXcfR/aSJNbjrfiZMQFaLRR03QGKUfAMPES8Yes+EV4Dm0lbgLFWXR
	/IodWYHFljT46O2TtueIXxCvtmGHPqxlvrEEXyZj1oB0Yz3oBHEc/SN2DlAgQIb7ZhPRrsLoLa6
	70RPGeQaeb0jOxHG/KXfzpnvdH1HsUOpzB575HbcwkBzt/rfMbVV5XsQb0z4nC2Vy1lIHuwMNK9
	7ZcbRJrQNGFwoQQp
X-Received: by 2002:a05:6000:401e:b0:43c:d665:3830 with SMTP id ffacd0b85a97d-45e5c59540bmr29643163f8f.32.1779186491437;
        Tue, 19 May 2026 03:28:11 -0700 (PDT)
X-Received: by 2002:a05:6000:401e:b0:43c:d665:3830 with SMTP id
 ffacd0b85a97d-45e5c59540bmr29643119f8f.32.1779186491106; Tue, 19 May 2026
 03:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511150648.685374-1-pbonzini@redhat.com> <20260511150648.685374-18-pbonzini@redhat.com>
 <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com> <b81cd916-a93f-4a8e-b534-2df59e61dd5f@intel.com>
In-Reply-To: <b81cd916-a93f-4a8e-b534-2df59e61dd5f@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 May 2026 12:27:59 +0200
X-Gm-Features: AVHnY4KpA2hL7NMOE3xrI2I2zuLCLwES8_fM86e8kYSRc1yro4Pqrht_VzfSAno
Message-ID: <CABgObfZmwyA39qDSZXMSypNG2ty849r8o0Pft=WjqQfLk4KMpA@mail.gmail.com>
Subject: Re: [PATCH 17/22] KVM: x86/mmu: pull struct kvm_pagewalk out of
 struct kvm_mmu
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Yosry Ahmed <yosry@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	jon@nutanix.com, mtosatti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:12=E2=80=AFAM Kishen Maloor <kishen.maloor@intel.=
com> wrote:
> +1, and I wonder if it helps to name the walkers after what they walk, to=
 shape one's conceptual model. E.g. cr3_walk (instead of cpu_walk) for the =
walker over CR3-rooted tables of the currently executing guest (L1's or L2'=
s CR3), and nested_tdp_walk for the walker over L1's nested EPT/NPT when L0=
 services L2. tdp_walk alone felt a bit vague =E2=80=94 it read as "the TDP=
 MMU's walker," whereas this specifically applies to the nested TDP path.

You are influenced by the old names though. If you stop thinking of
kvm_mmu and kvm_pagewalk as related in any way, it helps. kvm_pagewalk
exists independent of the MMU, except inasmuch a (shadow) kvm_mmu has
a kvm_pagewalk that it uses to walk the page tables it shadows.

Paolo

