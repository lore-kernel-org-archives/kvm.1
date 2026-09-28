Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53590331EBE
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558847; cv=none; b=iiwFripaIk2BbJj5nUJCZiXZIksRrJaZGuHLx5AuzgwFu9epi5Uwy3iuXPAjaargbS5qKmkqFAsH9M2P+DRWaM7mlqdn5ACwuVfO7bqOytbnVoo90yRaIG68cytr8wP1sHyC+3HGeg+k2ZkzqTAA2/8m02EGF6puU1XcYb8QFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558847; c=relaxed/simple;
	bh=rjaNAg+z04eA9ykYVMKBTQouCXeaLXvohfjJEkPN/as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2+H94IbQ0fAkg3uRYTxnm519hFpw3dVEUVqB6hExGpFj7eNSv9nQTsUQJsIiHX6SKkdw71wIokbpUxkY0b4ucWbzBt/zp2BT6wVzoZZc0cCMZ8xObp586SD59DRlNv6nXxep2T/F+x8SxH8oLTDkYKqW7ScORHt/uQU54k4i0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQ4aPz5T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDfabuGg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ4aPz5T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDfabuGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790558845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5votifnwitH8Ds1fhrux91JN6J8KXmnO59qVNlCSXwA=;
	b=bQ4aPz5Tklr+4Jix+7lUH72KJKQ7MCx9AoASNuH6G3s3cLiFiAUqezNAiX8GTqR4lgmmoS
	QlDiRmPy+2XLfQz2mKnec6YdXrVqWqrAe7OopKbizNDqO65z/cC+usIjq/Z7hlkMVE8hr6
	Tqnd6+Tbc4L0aIo1o7USGNL2wn7/t9c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-4Ez5AIv1NsGsSZ5VcJn6Lw-1; Sun, 27 Sep 2026 21:27:23 -0400
X-MC-Unique: 4Ez5AIv1NsGsSZ5VcJn6Lw-1
X-Mimecast-MFC-AGG-ID: 4Ez5AIv1NsGsSZ5VcJn6Lw_1790558843
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8710450f731so1646647b3a.0
        for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 18:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790558843; x=1791163643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5votifnwitH8Ds1fhrux91JN6J8KXmnO59qVNlCSXwA=;
        b=KDfabuGgZI3gsuDTsSOtdUXo5ZJy9PpgbE2HCbj2xwN6FqwHemy4xnTSwtam7+S9DB
         oQBtbhXXzh7cGOhyh19m1Ol5U7kcn9GAQuAn9xlCKpUGcLrm2IN1e0r8J+gZO3qo27u9
         YB8tewa9YlZGmbs8L3MbJpVmN+2pcArViI3yToPd9VWYq2v8egdXC1dR4cOS+aZzXiSp
         9NXVhsZibyncaln8ugnUegCAYw8rSLac7QLlFU0ldN9zvp942R3BjIfnXzu+RMP3NWgw
         aaotVi2Y5mzzi0GEirFui3F6P4ddOHGtAy3xB1NuXTXI2Tx7onRVA4gsIXmCg6YNSqrl
         iQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558843; x=1791163643;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5votifnwitH8Ds1fhrux91JN6J8KXmnO59qVNlCSXwA=;
        b=Sd1Hjg8aNjALPp2D9wQet85Ppke3e2Zi+4z2uouGQTZZwxIsPLSIQCFUav+O11sF8X
         zoZNYmot1xAwOvUb/pDMWFTCXRc8EfzLIED1POFwAgImPO3cce+kKg/Lc1KxLlo4b4Sv
         7tnm8DXNkgpR0c3wYLlSGf2bW4sOqrj1Pat4H0Xt8axD21VCa/jqCYRgKVQ6CauhukxQ
         qWKIcQkxwIgnNKHSV67zOm4BNzmjRBjuvzYAu8QE9ylMIdo7jPp5wx+Vffbz5HGhDR2f
         XxLpSOd6oJD0jOQaX/anUS7uVBsIZ8TWp6tAZaboNXXYgdQXoU0KeqXqNFMn9AblFIpW
         P2dw==
X-Forwarded-Encrypted: i=1; AKwUvBxwTfp32RM3KYOaeJ47+2nzySb4tg7ZnhPW1xq7WkDQgqX9Y8BrsTth91F7wJ5lQUaVjCQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m9fcU4mQf9OPGaYx0kJkqX0S8XtQutSTVwvYWen1cqiao+PiRW
	hUiP+p30e/mHY5MqgcnnOQ0pYVS3hDglpIquoaBi3i00iNrF39lu1rkBEO3GCp7vzeaCFV8ItZq
	YRLd1HaurR11IGiAGWpEze3Jzdt2m3yvUgwMPx1PlF0UlltUAnk3t2w==
X-Gm-Gg: AYBFou1OgTU9T4uxYJlbqqjiDIXR2/6jtiCcUrHiN/thJUWUQzr+zQT+PsZo0yWCx37
	Ky7Fuz4GR7QsN9XR0D/mVAZrZnhTPgT73D84MRKTpa84SVkpxnK1SDhEiAuIeu+UzAjQo5iTogX
	XoJMkdtmzcjsm5XZKay3RRZ1h0gSOvUf+gWMjZMkNmTYihcr0a1OaEECEmM4RhbOiqiDn2NrXqJ
	dIjdjBIejBnActH87Dzj4kyIWj0w7mSbOX+W6EBtQn/CN7LwZ7cbjpjQt1RYxX/SXk9jk9eVTBI
	aARebmTguTIJqfEyoa05ntK1eL36CpAmMXscZinbMa4B/I7qGHOiQ16h/ZBF/C7B3GHcc/90Nki
	ru6b0/iKnwTzhEOu3HCLOosfmKoDestODu9X3XStG1w==
X-Received: by 2002:a05:6a00:3d06:b0:869:c368:3675 with SMTP id d2e1a72fcca58-87e9aee4a61mr9245885b3a.17.1790558842670;
        Sun, 27 Sep 2026 18:27:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d06:b0:869:c368:3675 with SMTP id d2e1a72fcca58-87e9aee4a61mr9245873b3a.17.1790558842219;
        Sun, 27 Sep 2026 18:27:22 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-882d579ca0dsm907806b3a.21.2026.09.27.18.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 18:27:21 -0700 (PDT)
Message-ID: <2c7a9780-1846-4b5d-b743-42ee1bfdda22@redhat.com>
Date: Mon, 28 Sep 2026 11:27:14 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 14/20] KVM: arm64: CCA: Add bare minimal S2 operations
 for Realm
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260920212845.707-1-suzuki.poulose@arm.com>
 <20260920212845.707-15-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260920212845.707-15-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 7:28 AM, Suzuki K Poulose wrote:
> Add bare minimal MMU operation hooks for Realms. The mem_abort handling
> is chosen as the default KVM variant. However this cannot be reached for
> Realms yet and we would need real RMI command support to make it fully
> functional.
> 
> RMM takes care of the TLB flushing as required, when the Stage2 is
> modified. So host doesn't need to do anything explicitly. RMM doesn't
> support access flags for the stage2, even for the shared IPA.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kvm/mmu.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

