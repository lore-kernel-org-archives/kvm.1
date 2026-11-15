Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730235;
	b=Wxz1KcpTimj6WkpbNmCv+ioRkOTVw03HMoJ4yoSQlT6b/BUon0nBtH3es/Ur4PdhcND3
	 t2Ft3mkNzBhzaqdVi5NpRvZE6mNiyOxpRna/okj+xohdER8L/OXaa+BSGacog4BD2t+zD
	 eMtjAnliNPk3LxnehouyZC4xg7+B9JWo+pyFvtw5QjV49B0qVMcBawS0ctbd8t2vz1Cbn
	 M4t6StDqFsJGmYBx3/DUV1QdQ3rrsROSKbKUHkOTkmzZSaH4ApafJGJJ1+CmkRKPd/+mZ
	 O7dcEAfi2zkHoLc1IAjmQhdtBAMvE82XfwHv2R9LjEevkV9DSCTYBL4Y5WEX54d8LUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730235;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=3AD2NjAEnXh3TsyeQJyuQPBTmIH2AEBoMc1BO7pCl1I=;
	b=aE6lshWAR3mvmu/FjEBT3dSjDSLRoTvb1v1hiiE+JOWs6cLmtQDvpD/KHgvjYZ8BmRAP
	 jlICRVucfaaER4JCeCFWGBEuyXDuKJMtwk1QGx6cs/8TR7HgmmJ0mDj3XYpahkwaJmeDW
	 KihudLnCMtYhugufBQlGCGpNmLLifatHYiwa+rc4l6nkHFV3PixvEzw87XIAWyDFZolWd
	 mG1YMjYgA2TYJhbvKtN86mkF6BZpsDvBpTOWkzZLGv8yfv6mSn8NQAnpRlDaYx3yMOCn5
	 9ExHf9YFDjAxewbCpY6LhXquS+95O0DIFkeiEzl3gw4BpaQ2lkM3kZ3qoP6+ma93Fig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ER9zjlLy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="DB84/V9V";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071FB606A327
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 08:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 071FB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ER9zjlLy;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DB84/V9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794730234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AD2NjAEnXh3TsyeQJyuQPBTmIH2AEBoMc1BO7pCl1I=;
	b=ER9zjlLyt2rGDy7WZUDyp2bOCUfc6rx+WItUKIPqDQrOA3Js3Y2Eg08yvFBIIdeveAfDlR
	Nrw9yB14/bIRJuReGBeKq5QHFtk9heHLM9/wPlHfQ45MaZmwDr6qWlIW5DuGE5vbQ8DCMq
	0dc4+mMhwm91dKGw+L/2ROeTw770LDA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-sWUHTpbcNXOeNn6hXcRy_A-1; Sun, 15 Nov 2026 03:10:32 -0500
X-MC-Unique: sWUHTpbcNXOeNn6hXcRy_A-1
X-Mimecast-MFC-AGG-ID: sWUHTpbcNXOeNn6hXcRy_A_1794730231
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49034831bb3so1601842f8f.1
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 00:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794730231; x=1795335031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3AD2NjAEnXh3TsyeQJyuQPBTmIH2AEBoMc1BO7pCl1I=;
        b=DB84/V9VopxV8ZLFARtBAA6zG7pqGlYvH8XXCFVTB2aTa6rsPquz1BJnQppxmyrHmM
         5cO1/R+2Tbt1EUzrfazpxEFBqomVayQUIZDXzpxVy88SvSr5deTRD7my3Nlhpi+GcQpq
         fzrP5shcMfTx3s5jFgD2d4OpHi7X8FD5oC2SgcXre1/O8grzf+VWqA9tqQW3T5SuQoc9
         reTsJnm67xe8Sm3jrlWASFnouuggpQg29NWg202PpqXwXUqtubE9DS4xC66KYy5xh7eW
         GdKYXkjsah29akmliaksZ3AfisrQTKPIopg/W79dUg3FnfkDY1t5ERWuL19z3/Kr6ZWM
         ACfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794730231; x=1795335031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3AD2NjAEnXh3TsyeQJyuQPBTmIH2AEBoMc1BO7pCl1I=;
        b=CHUT4LNjRMO+kHqgq+HfN0o6KztlfZsJ4A69hRjXCL4odEiIUQyL75D/5S94Ss1jsh
         udhXed6X99sE9ULWE3B2bme5edAOES3EqKgGNCPdGmTTvS273jZ004QQwbJzpAHazW8u
         o+afr+j/weV3XrTViBFjN+2RBY6QGXXKzjGnbEavIPSStprLB+ssnVxcKqw9D6GXU3Gq
         Z1pCa4SDGee9VFzGJneHUlWeDqDa2RKE9IN7criqAznpI80jdu1NLrFqZGw/cGXDvRcQ
         GIDBRNny7/kM87dZyj/O6GHlP1jHRVtKuFn3SraHGcaxG9GjU/xGRshp3e41Nhw4NDZt
         IEtg==
X-Forwarded-Encrypted: i=1; AL+hErHjMgdqm31AIKHqTom0f6eMzKyWEsB2Nz1amK/In9JUXKGf3uzeWaWOv5VDVWVxJdBH/A8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3G1Q6i6H896HLf45gJX9kxZI7o+o3PgfWvxW6hqUNapWrfsOj
	SCi8j7+gOJ43shNYA3VOhmg4+bTzEUpMjSv/7g2u8MptqN7Y9Kd6q2J+PwHmMx0eJoWe/Pv0KAG
	CfOb9jjIEtYwFTIWBShCaSYtCVhM8glQEZcGXqc//TTEliXpFfJhyOA==
X-Gm-Gg: AYBFou0a8Pz6Z40FDNYqOHAOhu0qFeII743MhGwk7kPrr7EaIySdsEyRBLsvBrfmLiy
	I9SqSYAtdwiRQfsqbvQjmUZ7fH3tJmRtS7pphmOSd9UIIVXJLeILfPJimG2NhkgBv07lp3s07Ko
	XrknJ7L5vRXuP3bFxl/fEkj14AChUZM7omH5ew1d+xORaH2UEbYabl5Yam5Mr3emoAYvVd7Gw6M
	RkO0Bw7eaY5K5aqx46jQpUxVMRC9weliP88yYAf7uSxsMBjIcOHBhqNcXj6nWDxerg2/DF/vjJ5
	Wb643sczl5zLQVpQpvx7WZMSRkppkbMCcEGVOrD6V9j09ebJRO+9E8/69Wn+6C97fxMVEJq8tsP
	jBuq/CsRzYXe0928/I7qB53OBaP7L3x00lphRPPde+VnYtjyrNxYzUA==
X-Received: by 2002:a05:6000:25c6:b0:48c:77ad:d52d with SMTP id ffacd0b85a97d-49c73165309mr15480412f8f.43.1794730231243;
        Sun, 15 Nov 2026 00:10:31 -0800 (PST)
X-Received: by 2002:a05:6000:25c6:b0:48c:77ad:d52d with SMTP id ffacd0b85a97d-49c73165309mr15480342f8f.43.1794730230626;
        Sun, 15 Nov 2026 00:10:30 -0800 (PST)
Received: from sgarzare-redhat ([193.207.75.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c602dsm14853290f8f.46.2026.11.15.00.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:10:28 -0800 (PST)
Date: Sun, 15 Nov 2026 09:10:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>, 
	Chris Oo <cho@microsoft.com>
Subject: Re: [PATCH] KVM: SVM: Sync CR8 to the local APIC after marking the
 VMCB clean
Message-ID: <avlowrJCV-dgtAD3@sgarzare-redhat>
References: <20261113162556.461390-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113162556.461390-1-seanjc@google.com>

On Fri, Nov 13, 2026 at 08:25:56AM -0800, Sean Christopherson wrote:
>From: Chris Oo <cho@microsoft.com>
>
>Sync CR8 from the VMCB to the TPR *after* marking all VMCB fields as clean,
>as syncing CR8 can toggle the CR8 write intercept and thus mark INTERCEPTS
>as dirty.  Clobbering the dirty bit can result in KVM failing to detect CR8
>writes if the underlying "hardware" uses the clean bits to optimize VMRUN,
>e.g. when KVM is running on Hyper-V.
>
>Failure to intercept CR8 usually manifests as hangs when running Windows as
>L2, as KVM's view of vTPR stays high and so KVM never injects pending IRQs.
>
>Fixes: bb365a506b1e ("KVM: x86: Unconditionally recompute CR8 intercept on PPR update")
>Cc: stable@vger.kernel.org
>Cc: Carlos López <clopez@suse.de>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Not-signed-off-by: Chris Oo <cho@microsoft.com>
>[sean: rewrite changelog, massage comment]
>Signed-off-by: Sean Christopherson <seanjc@google.com>
>---

LGTM!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

