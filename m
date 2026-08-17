Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFD3ED10F
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006558; cv=none; b=R3PNZgEulMZsyaUWngbOVjqQSCrPDhSwrol1GMN1R525OlSMQrFfUZN88/x8u/tfAFDlPynN3FkggGWMbMhOhUfcEWD8In/CmNMaQbPTv/GsaTZgQmml9j6Mb5uX40haYCSzbFW+Qq0PVaCigH3xz67Ydh3cYiNil56ebjzak28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006558; c=relaxed/simple;
	bh=FuNV88XNhdg/KCJJbD5nToyPlj9YFC8j4Q/MsHmInqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6kE3X38xIH610i4q4IFbuBtcQ8vY6XXKufoX1RABaruFLYGCZRAtPhn0xtwnAmVTFwGmQ7A5cMgbSYYPUpuCOGeB99/Lg1eqbIC0pIGg82WUwA4lTfy+yged9zlq5r+mOZfNOLTOR+/9/KwImnWJSKa7qjdL6L8WgnNeEnyenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K235GxUR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K235GxUR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so35891575e9.2
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787006555; x=1787611355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAmbfwBAAjnfCUkjo5GeRKy1CTOwFpxCxG62IYGXyrg=;
        b=K235GxURVnm0J3cprUUUi+pRvkRP2RKd8OAmfYWViyOcEE/26gDXKscNOwCySZhaMW
         Vhhfvs/46tLXwo6zHnzVUPFyXDTJEY3+xyD3c1vORAhw70P7sCAaQT2a0Gb7rmejzG3h
         0MVYi3Qr+F2qmeqSQZBiEL8fB8gtaUzwhOkpZofwBmtGyH8nrf04m7qwVeLXuP/IKzKE
         Yyw4odOSHkp/9X2dm+qxhaDRiH374ZXsOkRZSw9pP6L1Ymk/ASwPDNa4FarLhS8A+000
         qyZdpyaITkjba6H5ETN4NYNVhRkuKWCxaNqqs9AJs0v2H20r+bDpKrKH2XsBKkgJu5mi
         xcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787006555; x=1787611355;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oAmbfwBAAjnfCUkjo5GeRKy1CTOwFpxCxG62IYGXyrg=;
        b=a5zyIQStQhl8ZX9QjuSROloqs760gZRQo4VMZXx0FZRX7hk53enruHMcYecoy9H8XC
         wweVqLrrvXr0C9uvnfHgVqJ7SRDSbzIgAsoQyHKOhRNwv1stgAdKwL5Vt1kqlu3cvk3K
         SI+QnYnOP8Xojtzh/gRkgDWI/1MpOYPagPf42Ufw++UXXtWLAuIdEYN8UwItyHhGR1Ic
         Hf8SC22/Lw4jI4yNsR6S8zOG17KW4SARRWt40iGiJGybQvQ53FNLOcrsTYBYTTZD+QFM
         PADhpRpbuCI0u1mcrx6t1rfQPF/M6IZxFn+2Cbd08oDqT8KIXSgMbs0EGnwuCSXmEEyJ
         32ig==
X-Gm-Message-State: AOJu0Ywwa5znKMOiV9leBfkcyWKZr+9GXxRxHsuu6hyZUNUl7QHp6wzq
	IKwCBmeHK3qI6vAQCVxvsKVTshvbzDBXvF4hmycU8CldOBRyYfrAGbtD
X-Gm-Gg: AR+sD10ukyxOdEkLY5mJ8t0PPiQ/ZtJIkpH2VMbLIrp4N6Y2RwLaRf5337oiQEc7B/o
	0k8uFtEITB2rUoeceVgz2YtRCEphKlk9Deo1Ir9fUq2Mqwcw591koXfuCQM1peha3HrjsZNR9wD
	o9w6YAbgX7LZVDAIGZY1QgW+8m2kqIj9A7aG5qxMLNDi47jjp8YooWjAqeI04mwyP+2EpB+pgdi
	JkhAQOl+eM56ig0nkxmyXSRUOTtj8fV2wEUCMsCJLf2ZrhcMuvbJRou2QMEG6LnQBBLDKusb/1m
	2IPON3tZjNJGd/FjiT3Mzq/RNradpqZDl8tYen8BIdWIBsqs3qIkEOUUKKmZtfpPp6VIMlX9MCA
	grbDE8jb1H/cJu/zoG7Yj3iBPhWkM/MB8Pd7vdD2TnAhmHFxHdL1Iqxfwjqo7lvj1o+HNLoG/sx
	+d5efpe4KRK5TClEA3RLlHyuorPv9BtM9CqD7SNqCmLJm2VLquuVVbhs6c9QGZ51DduAAAC0Q9l
	LGqFpKG2wV2YT3KjvsG9gth6gA4P47y/PKfTEjQli38+mrFgZX7lYZE6x1/WJ/ghKU=
X-Received: by 2002:a05:600c:871b:b0:499:8b00:5261 with SMTP id 5b1f17b1804b1-4998b0052cdmr426941915e9.8.1787006555013;
        Mon, 17 Aug 2026 15:42:35 -0700 (PDT)
Received: from ?IPV6:2407:d000:508:2027:2845:c930:d20a:3e10? ([2407:d000:508:2027:2845:c930:d20a:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a315d3sm7356187f8f.6.2026.08.17.15.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 15:42:34 -0700 (PDT)
Message-ID: <8d069fe1-a5b6-4a86-9604-26aebe2dc243@gmail.com>
Date: Tue, 18 Aug 2026 03:42:31 +0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260803170825.925561-4-hisamshar@gmail.com>
 <20260817220457.554823-3-hisamshar@gmail.com> <aoOKMeua-cNeTxXT@google.com>
Content-Language: en-US
From: Hisam Mehboob <hisamshar@gmail.com>
In-Reply-To: <aoOKMeua-cNeTxXT@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/26 03:24, Sean Christopherson wrote:
> On Tue, Aug 18, 2026, Hisam Mehboob wrote:
>> Gentle ping on this patch; it has been on the list since Aug 3 without
>> any comments.
> 
> Patience, please.  This is on my list of things to grab for 7.4.  You posted right
> at the end of a cycle, shortly before the merge window, and the code in question
> has existed for years, i.e. it didn't seem urgent enough to squeeze into 7.3.
> 
> If this is the very last thing needed to unblock musl builds of KVM selftests,
> than that changes things, but IIRC there are other "fix selftests builds with musl"
> patches floating around.

No, this isn't the last blocker. I verified with musl-gcc on x86_64:
with only this patch applied, the build still fails in steal_time.c on
pthread_attr_setaffinity_np() -- it also needs your task-pinning fix
("KVM: selftests: Use KVM's task pinning APIs in steal_time", which I
resent). With both applied, the musl build passes.

> 
>> The musl build failure it fixes is still present in current trees, and
>> the v1 feedback was addressed in this version. Could it be queued in
>> kvm-next?
>>
>> Thanks,
>> Hisam

