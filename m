Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795319578;
	b=P3AWv1YRdFZcU4lPXzlgKLIVL8CG8L4BlHr7/bDP3dIqdeZqrgvVukZ15+tyaELkadgp
	 cvV1K4FKI3afxEuejpnb61NcopYNBDdFzoNTw0Wzh+yCEDkuIYbS05qnmdaOgWP182bbO
	 E+wtCag+YxbhaWEAbZeYtnkoQtSBO32A3M46B6wavxZ6arMcziUEsb7rV+pTlQroz1n/F
	 MqwUFYH4/NkuIDX3yECK3JNXTYrANHvCy9DL2RziFKJQM13UPt8qRaq8lc6a3r8w99zH8
	 NI24Q8YMvmo1phXStNuRCnUMb+Tk1Shq9Ihi2mRO7VVuGamvNv8qCzTreXw7shMJibA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795319578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:In-Reply-To:Date:Message-ID:References;
	bh=3/acJDvQZeUDuSHYPSXBbXR1HyKyAQ1dnjG4woxCX1E=;
	b=OdVGMlxq6Lmiglee3yOptG/5UZtWMXNteEbxXhkNlYxm+HTfXZAxvJaTDcxA7mYuqutV
	 YEsXzwwxUYImWDxIwJKM+s0dEbwlT5eIVDM9bCUtDiDGhvg9cmz7wbkQX6G+RM7TYqVom
	 1xwjhTZePdygoE6szCo8JvyMPZV+IcfagE31V/gyxcgbuSk8tQmazjW3QVNsVddHt4wE7
	 XSMF6CfM/APCbE67Wrr0Jd8Bq1PFztmMK5ewFMdSP/68PdtHgSDtb8q1WNpDeQN009rrq
	 Fn3IJhMik8qswr4tRd0pvNOTD29iJyWmRtsFNKzzEE79ekeiyG4upjFyvQI1DjGJLxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KO2CK3Uy;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F0606A32C
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 03:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 369F0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KO2CK3Uy
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3869b68caecso2117367eec.0
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 19:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795319577; x=1795924377; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3/acJDvQZeUDuSHYPSXBbXR1HyKyAQ1dnjG4woxCX1E=;
        b=KO2CK3UyhXKE9D8xAFZWzqSwNZ1K/eoQn5DSm2PlhJKM088S3y58HlUXE4CbPZAdtn
         y7bfEsI1UIgnWN+HmIx+Fw7w62DQk2njd5LCl0EJdhsAYx896chKGa0F+2QaHGnqqPVe
         aapCRybowlt02Vytgvofs+1mkSU6VKfFglgZY1a3chaiNkr2D1WJBcQpVhkWdhxlrbzd
         vcctgjM1ySlRoQgc5V4VRv/fio6ELy3CNfwnM6X0wnjs09XPp1mRxkruc1+dqUPWDV2f
         TgeWB7Lmeo9HKd3tb8O39SavkUEtS02Hnt8ZhljvSy4u9rFYd8aPUmpkTTqu8wWzu/aH
         x7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795319577; x=1795924377;
        h=references:message-id:date:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/acJDvQZeUDuSHYPSXBbXR1HyKyAQ1dnjG4woxCX1E=;
        b=ir6ELv3D+3XdgIlK2aincgSR8q5I01JFpBPP6tC5l9pIvIcFBFB1OFKNveqyYOOS3l
         2dKtDrPxiF49tUPQllK8N2T/BOS70y2SkGGHNLtBDL59uei/dJX2A4ms6FRNks+PDOAw
         egQf1ZcMF/p1Tv+zZ4bR8utepfx//SoTAJmfvaKXAUBLvRZqG/wX64XNgM68Zvo6P50C
         i+AGgDYiNYUftXoTP5CgUcwst9aeKvnWlMmuJ26FARo7EUuFs4ivxrswfXhniWKrTxhX
         3fasfPkJP0z236ib7C2DQbH+N99QEEBAH8mPHCjmlJSdnWY3Tda0VhxL2A/b2+GlWN4G
         abcg==
X-Forwarded-Encrypted: i=1; AL+hErHYmUMIDIkPPgx39ELiRKy7CVdkmEFPVAik+SD7+ltwD4iRHxde58o8c+Ji5/oNmjvJFDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8T74tQVYiWS1tAuVsZU362lnBysmzgTobra38CW5uqT6z4rSId
	59/x3KJ2W+1NT0um8kYmDB9TsyIKsak8OGmp/MHDIVLEbmSbF0nVTeDe
X-Gm-Gg: AZFdTZcJS4oV2e/qheiYCCKSp/03jCUVYAw4Rw8lDsu7RQP45zA2Imxfu6p/TALSTb3
	9sLVGRWxzu76X0L5jwgHiexqb/Wl3wttVDQHcz4DE8mdRBxP2FlLMWM2D3+IEv/AGehYnyUST/k
	ct5qbJufmNb0J8+MpH6D7yc95X3fKavlblaC4BbXYr1fBzcp7hhu5/UAuI27qjZDLeF4hR4TOsH
	44Aq+Lmi7czpgx1As9wNpNsOjcf9BPv0bLRanoNVY0jKOPK9VjQJlvbpSaGzSOYXHZMRwUXkp28
	+7FkdukgFVwsx82LQRhL2hoX1PjAylpA2+h6js5EQULaMpPWhV1GeJqgZC1n49/hMBFE/fmBwl7
	FsM4QD41ZtOTuhlKAwEjy4FMFEUtejMA6b/ebIyVPW55jbYJpxPhenW4r/DqIhI0iKVVM1TR96A
	fpjTWVLkVcI9O3LFThS/hQhr1/JP7Y+Xu6+4/WB+buyEIGyP90dsnVEWT/Ajc6HZLIRx3IMrnMl
	8COZLDxVvrnlf/eJYb1NmaZyUkvtYnbK+4OUPhpvpBgtuHNYtcPxbEp6fwQ/kV61QFo/TtToeWs
	lLlxKBJdOxtd7wPNDztvwroBwH6WUUXoNTWx60KILR9mgDVr
X-Received: by 2002:a05:7300:e9ce:10b0:385:2564:c509 with SMTP id 5a478bee46e88-385700541a6mr9198641eec.24.1795319577262;
        Sat, 21 Nov 2026 19:52:57 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm22045349eec.23.2026.11.21.19.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 19:52:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: remove unnecessary #ifdef
In-Reply-To: <20261120133413.475489-1-pbonzini@redhat.com>
Date: Sun, 22 Nov 2026 09:13:29 +0530
Message-ID: <tsl9jztq.ritesh.list@gmail.com>
References: <20261120133413.475489-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list


++ linuxppc-dev 

Paolo Bonzini <pbonzini@redhat.com> writes:

> booke.o is only built as part of kvm-e500-objs (which is conditional
> on $(CONFIG_KVM_E500V2)) or kvm-e500mc-objs (likewise conditional
> on $(CONFIG_KVM_E500MC)).  Thus, the #ifdef in kvmppc_core_check_requests
> is always true.  Remove it.
>

That is correct. Looks like after KVM_440 removal via the following
commit, the above is always true.

commit b2677b8dd8de0dc1496ede4da09b9dfd59f15cea
Author: Alexander Graf <agraf@suse.de>
Date:   Fri Jul 25 10:38:59 2014 +0200

    KVM: PPC: Remove 440 support
 

Thanks for spotting it. LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

