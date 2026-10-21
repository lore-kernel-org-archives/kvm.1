Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792626194;
	b=GRkwRVrB7c4v74KPxa4a6f4DEe7MkA40ALQdx9SXzQHkc9K7E9NmAetEFB2JMTzx1HlD
	 PVy3m/8Ppqj5Vm1KNwp03RuVIGRx9VRrkr1T3QbCnhnLoSbqttT9FPOk4Szg2Y7+ZJvH+
	 XnwoDVO8UbGAizSFkst19SR9baMuy5zZFXqYpg22I81xPWNRAMgnPBN+KhMNR0V2nSk0B
	 an4Ugou6dTXnn8eknz75lj0Er4NnYx/BdWiqcbiumq86o1TzP56558YIGj3F1/UnS2KRR
	 RrkqoPd86tZN6rlR/AtKF0DeOdhYRC6kP1T07PMBMPXuekPl/QprOUBECgTkMCD/vqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xqMxgDGxhPiOyoUaqZji5WTWN8A1cJANGbLxRlZzHO4=;
	b=Gf+JTT41jF1sC7fyZ56tGLHJoilrgitCfEunLRHN3/E5dPQhOYFldUcg4cONKWVu/tX5
	 ShZhifBiVjBIjkxk3grXbg72ZSFMV62qVTzDpCsPSDaX5ODJ8dmWOIctKk9WlQMQJKr55
	 aBehtz7Fza6UBiLhnLZ3KIHP/xkILGlKAkXNWRwEMPcnZUN+fIIN8qbGnPVkuIxXgpEnH
	 9F6d4piomS5soJlpmQyXQxlxXP03W//y4ldao3EPaA1Iz/mDVK3FcxdiSmX4bP+ksV/3I
	 OR4nx/ovFYAjiObR0P3UFSzMJfL1iRwRJp5RjAUrA/99s6kKQBO3NXLR9cY89ryuc2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="E/pSRgKi";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16A606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE16A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=E/pSRgKi
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso5206a12.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792626192; cv=none;
        d=google.com; s=arc-20260327;
        b=H35BvwkBMbo36uOp1tTpnV8ZsUf9cB2dms0BulKSc4LVwAbk/9cf+Ts2KgLCda3LoX
         0wZJ2zwLCVD88iiFaE1NB7UOcW7S8v0oUYpKJxhmfNRlb2eupjIiLd3UHWGM8qIImmCZ
         y28HRSEVxbFhZn+x09t3wg04R/hPZNN6ZxxpYTXeb1NobWej/wzF+Y8Wy8vELQPRtvQo
         3eHvOrdkOItpJOteIf3EkC1Ef5U2b1uGWRG4A/7wuKppd7tdNMcd+Mqg6VWL2RO3jhTq
         bYJeOp2RZFIBnl3saGJHf8tiZS2vkabnqq6sn3Btz2+xicQlmvkTpX1DrNp+LT4odWI8
         TWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xqMxgDGxhPiOyoUaqZji5WTWN8A1cJANGbLxRlZzHO4=;
        fh=hs7nDZ7SZo/OGHr5IXA0HA0H3XqTZxf3Eza0npkWaj8=;
        b=S3h3GSNWx5Oxlyr3CvGhvfAV7nnEP5r4aGkDdniJ678ZDiQepgvnwOUpbnctFre2Nz
         kRjTefiJfUwFV4r1em9wIASiu1uvMNxAuhMXVTWIPr1WJKoVBOfZI8cipLazfDZAbDC5
         uB2iDFMWODoM/vTApGAQiXhvOrJnP7v34Vgj9jRCWNRTbgFQs4Og4nLsQIZh5F5iUWXV
         2iiJCdh72rD/ZkNoDW8k8J7C2tJaXLnoJiy8su6XZKSncKVUzWh9KFsDGQLg8JJ7qX5+
         mKa8aiK54QAktGg/qwmU/rEzkhZ7rLebOS/ExdxgzYbEVyk0FgOcoOaMBgiMNDEOWWSr
         Xg2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792626192; x=1793230992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xqMxgDGxhPiOyoUaqZji5WTWN8A1cJANGbLxRlZzHO4=;
        b=E/pSRgKiSBZy4zxBZHAxR+Cn7Pbrl1+eSF/eoVUZkoIMhcUMBUlN16ijRFpClyQV3F
         6U+fMImI/i2OA9edQS/R8+MzjIeNITkC8gQg/fB6iL9XQf5P0R+ihIZ3O/0DOXM6EOW4
         F8E62q6XZOCUcX2UBZ6UO5aA3v6ersGKPdRhNpwSHv9whuZbVcQxHSGzidSZ6dryV0z3
         1sVXCl8YeTS5JaeIYZZVsnPUzYY95Bl0Pyjmo2Qbtlh4g1QAkCRNAOVDWynRLlOkBVs5
         wzDCEHPHo+fUwmq09WrnOlBkqeDIhURHAZ1Qw074Lpy/pneo2B//sIk5GjHM5QskAupI
         zHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626192; x=1793230992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqMxgDGxhPiOyoUaqZji5WTWN8A1cJANGbLxRlZzHO4=;
        b=IPGro6EyjUMDIi/VGEURIDWylxeCyi6IPI0k9gn672UG9MO9P3Vp3PI2rNsZLWjTT1
         tjIbbz5h1eFj2Xd5nfCo0p7hlglXS4oG63AE/hJ0ns3FnuBWx8jK5IdVWLcjbab4YkiR
         HNkmXztFoLAFYaMp4U/G+zFLuwVh9+yhx/i/tM9RtNUKHCvyx6n7PQ8avnSXNIAlOJ/+
         /TKXOxKQREj0CehI/+r/UwKOEDow3kOtDe6l47Jp715Y+TSp/4L77ZvQCjaMPsQsHj0m
         KB1tv2myLdhHXHQrQhrFcPESMQCxqhcc1py5UKSnFmEOK+evAY3OrUPBXP78G23VjSPd
         gyRg==
X-Forwarded-Encrypted: i=1; AKwUvBzf0Z6GWHqHrXs5iwbP5qsXGmYbTCdwTYoDWpQ6fgU1fCTzG8MD5JjtqR2691r8Tc6LMSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEXRV6Eeh940bmINi0Khoz/s6HqhQ5GL5EbbsNYvW88VKcL3H0
	xgcH3CceyDi5RwOACN5UDz477TEVbywEBaIoe72hTz2GTzm2zJMN8bcT59pP/VKgM5SgF7yUGwa
	/j7Xd9C4dzcz4z4UzgIH8Tezu47V4Kn/C2hh+1D6E
X-Gm-Gg: AYBFou2TEL5j1Gz77aSUHsSvZ+/X1SzjMtL/tvczqfJSkFaAA0ja/1MeXfIKbKlryIw
	MTTyv7vbkekywUz5Now+uJ2Dyej/Cru4SxDRMVSFGHSKoeByVut8NJuDGba1gdgteiNK6Qoz5tp
	hctAinn/AIR2D7P1CoDWNqSm7XsZBH8qskmBDgRMcmoR5U1Nt6M9p142wyWFGUJW5VHeeoXkWAn
	kpOmiLDyaWNZIP9Q0wtNWZXK3ryvho0t00zqoK+6R/V/TJ6oeB3786/qlr2GmBaKXK+eTcMVf0B
	8AlZZJRf7NFVU0alLEdrtkVPqKvFdUkWQvK8UQa7LbpEAhkrk3RQNVO2nL41n0q9z9MonjEwsIt
	aULEGxGWjmMmHu/Y1pZUHgaDk/l3G6pJPQJqy
X-Received: by 2002:a05:6402:270c:b0:6ac:84a2:bdc7 with SMTP id
 4fb4d7f45d1cf-6b420321f14mr12746a12.15.1792626191849; Wed, 21 Oct 2026
 16:43:11 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-6-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-6-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 21 Oct 2026 16:42:59 -0700
X-Gm-Features: AclHuK9wm8PUCEYtAidiUragN1S-msumWFyv__Om700jGHu3sB28SCGOAFOtB-M
Message-ID: <CALMp9eSX7aDK8+126wbGEOSonTs1+g6VFPTMxXtS-1-HHWFn5g@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] KVM: x86: Add support for Live Migration
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:07=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> Report the LBRv2 MSRs through KVM_GET_MSR_INDEX_LIST so that userspace
> can save and restore them across live migration.
>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
>
> Changes in v2:
> * New patch.
> * Lets userspace save/restore the LBRv2 MSRs through
>   KVM_{GET,SET}_MSRS.
>
> ---

The shortlog should probably be something like "KVM: x86: Add LBRv2
MSRs to msrs_to_save"

Reviewed-by: Jim Mattson <jmattson@google.com>
