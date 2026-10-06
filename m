Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEBE322A
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245007; cv=none; b=KoDNM88gAUQQjpUDXN98Yqz8fJ0NeIixtlW6EMGUy+a5DxwO2brFHfxq+S9Fqzsp8lvjvSsfgQ6ZqEd+epH8638OZ8mVT8uwRsig8BrPzxNukwcPZwAJRGnxBy2YmE5pw3HlrqASKbs5O4vLHknIoeiun/ipkxYqB+uxazzr65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245007; c=relaxed/simple;
	bh=r/xyKW/+NyCSyYJfFfr1Na2zRDCsUAkIxdQRW3XIkgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+lZeq8R/JNQZlxAepNQMVqbJ17XO4h6o/8VURySJdo7b2LFouLRyGKM2eAcKcfFduJBmP4TOPOX7agY/7Jkdl7JHHHYpAl65Xz/ad3X2Ku8atpZUAomj5OFmpNETJYX+2PYDxKZbIpD1g3xZS9QrKVMhC2ua0Rg//U6gwWLD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aw8UDg2G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+tIk5pr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aw8UDg2G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+tIk5pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791245005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3isgNN8kiLtIbsG19uUxm1RN+HXpbBndqmLznSpT6Ig=;
	b=Aw8UDg2G2rfKxc/HuGLXOmtEbU5tAE0huAzZaMMYu02ocudaaMdm0mIIRbNMrH2V8IZU+d
	OAKKxGKtYAO4el4Gs66cBI6IrcJJi4mp0KjEJhWSXM8bFk2vFUWSt/SRQbSRSZxiMAW3EY
	jlDEyJe+t+ll1oUTnOfC4938E6KUlwA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-jHX1jzbfOZa2AWfdjddM6g-1; Mon, 05 Oct 2026 20:03:23 -0400
X-MC-Unique: jHX1jzbfOZa2AWfdjddM6g-1
X-Mimecast-MFC-AGG-ID: jHX1jzbfOZa2AWfdjddM6g_1791245003
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39deb05ef51so2188189a91.3
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 17:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791245003; x=1791849803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3isgNN8kiLtIbsG19uUxm1RN+HXpbBndqmLznSpT6Ig=;
        b=V+tIk5prA8Rr1SVLSxe8icbMarGm50FUzoouWSNqf7DyOEG5SSRV9F3ygwNXd2JhD3
         rXZEWpjWNcsOawcJu52ACfslMx732SBeofMdRhLR04vUMuSTHA8uCPCEvzq5+DOFMvxW
         +l9lF13cOXULEciEgop6jcI7dwgW4+Z4Yj+5nysSGqRlAdDF+y4zadKyHylhomBHGk5k
         ZaiYRDu2wxCViDsddd0LWX68LFU6roCBDOljNQdTydpPnjPGIcqmp1ZBVsXkYZ+SoicW
         E3Q2lmT8nxNPhQ5Tzqh+6Xci49p9xwQdLTZYNB0PfF7P+bTrTCd6pdHZzIl5WKVwNn/W
         vssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791245003; x=1791849803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3isgNN8kiLtIbsG19uUxm1RN+HXpbBndqmLznSpT6Ig=;
        b=k/RWF3eACaJFmkR/6czyFIn+dsIr4TlHwyEgt1Xi5fuhvN6pX+EA3XWmz67+hvfP34
         Y3cl7sGp8wh5Bv1dwVqAc2O6EcPLKnRtqIDFTRekl4HdsTcs6zkYb/mPAXizvaU83Ytb
         v97JEQjb5c+JfdyUKmIA6jZT7EI/gnwbcu4aZdNLHa17s8zc+LGknaCq726KYj3GG2q/
         FMTG5ehF9u95uRbvBgRPZ5WgNbZpUv2/9lIK6Ujhdny9HtImMjKwXhLKSnUpf6ekKNYJ
         wbyI0kUI6ZrxtBXCOp4zyqywaR4auSfNOA17TDS6Nz7zjq/ZcQSP1PDbqNr24e11bUKp
         h+Qw==
X-Forwarded-Encrypted: i=1; AKwUvBxvBmsnj6AG/R2ovHKdhRMF9h+YZTLzVO/6hUaNKmm7/ERWmJY0Ni8fG9UeIr5p6pWfHP0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrRNg1CKlAKoabmalhoTccGkatyoNI8pNgMQzsm/aL8L/rl0qz
	BJ35ZQCGWadsdTYGYO61OZGspOzOUApa9CsjcUueRUNcS08hJzm9sVH8Ar7f5AZqDpu2QuTXsiY
	gFBh1QtY3aqSD2pXzgAjlrnHPXuSfC4HoSSjlq3wwnT67jBapdz+GWg==
X-Gm-Gg: AYBFou27rCekKi9jfw5/CZJLyUe7xsxDlYFn/gmsOZdixRLIo2HUg6HysKFUxm2f1p4
	GjLUWqlxVpDtOHl9GVu5eNLoRfjtS8soLThogO3sXTurY82AvbBQJgnpk5ytHjLHGATB3OaLCXI
	1MYbvWPP93IgqemYyHnLfI4NRkL1ca8AyyrxxPSvPo+Z+PAS97qJEurdwmmaSKwmlWiEwi36F1e
	8BB2WV8tFBEBG1M7X2iA7BxBwukQvAdGmkGHr9wnrcabW0WhSlh+5z5nCLL0PsalXIbCprh8h/R
	RgSJEML+PLzKaVUalcgnzyOnglXVcBuIC3YmZxRu1jt9TqVA3ezxPdf0M7nCoLNXhwRgWNO1Yl4
	zhaeMqkLhkGeTWsbS6t162zxDeJdwC6nbZvr/td1QRA==
X-Received: by 2002:a17:90b:39b0:b0:3a4:c8d2:6c2c with SMTP id 98e67ed59e1d1-3a6ce845d78mr5199381a91.49.1791245002602;
        Mon, 05 Oct 2026 17:03:22 -0700 (PDT)
X-Received: by 2002:a17:90b:39b0:b0:3a4:c8d2:6c2c with SMTP id 98e67ed59e1d1-3a6ce845d78mr5199369a91.49.1791245002098;
        Mon, 05 Oct 2026 17:03:22 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dcbdd97fsm8611158a91.0.2026.10.05.17.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 17:03:21 -0700 (PDT)
Message-ID: <7b196a7f-d31a-4acd-9f3f-a24c0e78db43@redhat.com>
Date: Tue, 6 Oct 2026 10:03:11 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 02/23] KVM: arm64: Disable Steal time accounting for
 protected guests
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com,
 Fuad Tabba <fuad.tabba@linux.dev>
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-3-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-3-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> PVTIME support is advertised by KVM_CAP_STEAL_TIME, which doesn't take into
> account the kvm instance. Even with that, a VMM could skip the CAP check
> and proceed to configure the PVTIME as we don't do further check on the
> DEVICE_CTRL. Tighten this up by passing the KVM instance around wherever
> possible and catch things early.
> 
> Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/include/asm/kvm_host.h |  2 +-
>   arch/arm64/kvm/arm.c              |  2 +-
>   arch/arm64/kvm/pvtime.c           | 14 +++++++-------
>   3 files changed, 9 insertions(+), 9 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

