Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23A1E505
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246577; cv=none; b=UMQ8Fk/u+0A614svqVrP5BbL9TJdlk2/GnectvvmvHawGhbqLF/ktDURqVUdAiB4PJk149AAOiw3Th1RB8EeUlWSep+zJPUYc40UWEkKONDfVGLTNPbArd2mBIybnEVX0gySMKuW0dSVxlqVExcDRyJm69DVRJulysua8vblRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246577; c=relaxed/simple;
	bh=Ep/O91QiOVfVW8jwrv1LXJ3OUte/E8KeD2kAa4PCIvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fc0k1W1EpUmKZa6rllVyKiWaw0HvgD3r0znvDzgRQxd6N53TPxwUdy1vXdKWqIepQCkR9GFsj61JAlXI2eSgJnBM8eT5uwZfqiaIwRZ8WN1OXl8HHpn5r9TbMgVYauivpM+W5Ahs7GlIYAWHvxEcvYfzReBamxNq9Ck+dfSW2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lwm0EYDB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EzDKBA1r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lwm0EYDB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzDKBA1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791246571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dKXjEUftIgp77OKHDO3ncsIawS7cJdjkrLy6a3G9XM=;
	b=Lwm0EYDB2YdRNMSffPt5s9I5XyFwZe0QTW5jqlOiZ//aDbER7CieZVYnYMy/AalpEQMDMd
	2JZWkkBuYw12cHFiXT2ittFI/6jIWT4puvuBMWSWOVtauAPyvam+poz3LT3StPt6Z8CJ4E
	Pq9uuYiS9lLxbvDbWKSFvMiSPXKpa5s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-PcYq7kZlPNCh5k1b-Mfeag-1; Mon, 05 Oct 2026 20:29:25 -0400
X-MC-Unique: PcYq7kZlPNCh5k1b-Mfeag-1
X-Mimecast-MFC-AGG-ID: PcYq7kZlPNCh5k1b-Mfeag_1791246563
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a813204f87so1224625a91.3
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 17:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791246563; x=1791851363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2dKXjEUftIgp77OKHDO3ncsIawS7cJdjkrLy6a3G9XM=;
        b=EzDKBA1rtzlCODexHfE4HD/8pfUG2ADlnAfgFHU3A832FWAxAzs6vIyD2hyhGZiDf2
         JLisALDqkp0HIWsZ7qEzmJkYfDeFqs7nOKOfzyy0qEMPexTHR2451UJUfkTz3XeM7L+i
         TPNGBtUXcoykerk81rebljwdb2cdb3epzbZwq8nNYsVB6bhg1KgRa79kEQR4CExzJIRm
         rmFGUnVQRJnqJsL8f1in172EQgVCoxiBsWJ//yCbXTe0A+KW/f1EJW1AbysQc8pl7JSP
         jqd5KbzTNLKFacb7nRzwO5neDiW4R+ShqZQxqCava08Lu3x+kyzcE6FqGF3pRE78+H94
         IgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791246563; x=1791851363;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2dKXjEUftIgp77OKHDO3ncsIawS7cJdjkrLy6a3G9XM=;
        b=FtHBgOW7QWdMdXqKBoXmTrOlz3wAIhRxTKzxfUSLAmO7N0BfY6INmWbW4f3EB9tk45
         9/tw0plW+Ql3mnVHysnCV2O1W7iWZOsl50GMZRftZ22oUeatHixzZuhAIbsysHUBUV60
         FMAxLrxJDqKa+jo63qBKZKbSUoAZNdBtoQClMxU7QSxskWjUmf9TtzdZnzevZZtz5ytZ
         FtGhojLZbcLFLwd/pvQVVYxwy5bSvrEAzb2zq112d98+ifN2VQFKU68WQrcct1IhxQI/
         dh6plGMzdsBk0dtKxpAL0ppYOlTBKxB5n7RfU+e9qRoUwWfhpMh65SQZOvsUWB4DfsRF
         o4PA==
X-Forwarded-Encrypted: i=1; AKwUvBxJozZ6oqlwlOwQmqwlVarSTAF2FB6hieOEr6ghBDhnH1s2K4kOZlpyLOjwWrb9v82mBsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSQuFE2Z3qlN79/fnr6B9vwDnljDtuqrBCh1y8kOZ1CZJjKBES
	JB1xnyUR8qWDMD/5OBwh16feI4JsKUzcAqD6yMFlsy4fliY5eASW5cPr+dnbeViMljNVnTE2B1b
	9MAk3K93p/kxnWWBZ7utqoDwMT3/+tyzCKH+tFDYq4CHdJc1WVZxeDQ==
X-Gm-Gg: AYBFou3xmr5UBFZxEPEDZvSHV2wWtTSimBhYBjT9ZIzwtDNATMaeNWnT3FGnEkvoOBg
	bvvORXtMwEQ2DyK5UKA4Uh4TfpnfnNH04LAmbIITkeolp0JxrSzP+NyKogjtFizt47VlTuzHv9V
	gXd8Ln5bn77ZeiJztY1NujOqmZqNX2BQms5yBJg61c0AlJtSFWGRanBhWnklYeam+EeacfV3gus
	f2Xu8pQWVeechJ5ObPtE+X9h6Eb6dk4XQOjnOeoLVqnQ4tNG6/drkGzvjplrXC8+xBjcO609DfE
	HdkZi+wL4DhAB8m9Uod4mTo9jotU9SPRI7Dlmbt1Oi/wsv+CV0C5F9AZpfeFe/huwPOEel9VzzQ
	sfqvO/EWhCNhvQzhxsSUSU1PcQlfgn13TuKyqAstqig==
X-Received: by 2002:a17:90b:164d:b0:3a8:163b:b06b with SMTP id 98e67ed59e1d1-3a8163bb193mr3223746a91.57.1791246563192;
        Mon, 05 Oct 2026 17:29:23 -0700 (PDT)
X-Received: by 2002:a17:90b:164d:b0:3a8:163b:b06b with SMTP id 98e67ed59e1d1-3a8163bb193mr3223706a91.57.1791246562693;
        Mon, 05 Oct 2026 17:29:22 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533abe0asm1954324a91.1.2026.10.05.17.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 17:29:22 -0700 (PDT)
Message-ID: <9536a477-3d66-471b-b58a-b941e4a372fc@redhat.com>
Date: Tue, 6 Oct 2026 10:29:13 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 06/23] KVM: arm64: Don't call vcpu_set_pauth_traps for
 pKVM host
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-7-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-7-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> vcpu_set_pauth_traps() bails out and does nothing for pKVM hosts.
> Clean this up by moving the is_protected_kvm_enabled() check to the
> caller, in preparation for adding VM specific vcpu load/put callbacks.
> 
> While at it, do an early return if the vcpu doesn't have ptrauth.
> 
> No functional changes
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v19:
>   - New patch, since addition of this to the Refactoring patch makes it a bit
>     more bigger and harder to review
> ---
>   arch/arm64/kvm/arm.c | 52 +++++++++++++++++++++++---------------------
>   1 file changed, 27 insertions(+), 25 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

