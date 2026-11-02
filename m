Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623756;
	b=xENqzXy9ABejM6nSgtsN1gpOZBnDtz5R8d96S9kuy+w7R71Ot75Jfpexn2W1hhcVEfYr
	 W3qLJ7113LptYmAYy6JWiY86J7cbQ/a10akKRq1Vngz4JL0gL2A1L29BzeMFkcloSRpP4
	 KBT2v9A7d4H/634c9HlbRYpP43GbVl+/4P/pyb8YFkFFaVuekVvrpsY5ef12znCAGQULc
	 xDtlJAsgB+uBlDuDksXtRURNrs5E+GrbE7tc0pnGNCvVal57toLamSSDvEsdXUho1cFWD
	 AfJAbQbulyRrtaWgbfsiij/xkApqgji4BRH2obMpNmAllPRuxpjgun1Y0MD5FjzNsrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i8NTQB3dN2QpIdebJsLSmUNNG/IYt0L9NmfBKr3dfDw=;
	b=4wyuWNanRxpWvaejpXFAVpR0MXvG2QD1vkhK3DTr6K9NX9yLWZj2STYYcuKotBIKf2Mq
	 0tLX0Du/cgPk3AetvOCc8jNQgeZPglrvYwsJpe3xTMyNbuddwcr/xR4w8Fd4f3/HcAfNl
	 48J4099pvjBiI6WFkVwNX1u5czfZFPPzC2r1+rFZuaSHANHUehMdX3/lD59yTRgkdS4ZW
	 iZAoe+sN/IH/V0QWWndsw7D2I5FUE/R9DIRGLIgAFyNXsbEOT+0QOSyvgWBsOWaoq6Gh8
	 Ey19EohYxXIjNlkn2s7EZLL6KTikoKE3ZBmNPErJpFiTkeXug4PHylUU+7gjoLwkwwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=NpuobCOD;
	arc=none smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445B60A3839
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 12:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6445B60A3839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=NpuobCOD
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bfa686881fso2294538e87.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 04:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793623749; x=1794228549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i8NTQB3dN2QpIdebJsLSmUNNG/IYt0L9NmfBKr3dfDw=;
        b=NpuobCODsaeMaWK3KSJ7CYeFzFjejBe/CdpSaMImxO/psFfYWNgksAz6IaQBHVoGnw
         yG4TCf9GwWszKn5P0wcTjS5/F7bSf5w6P8cLbEzmHkhdfS4xOg4xf7JMiocrxffE62mH
         DVHo0o1CX5jLPh/fOcr4yzR01YrMQb2/9QMO2M4askf2lmuroalMbTS/uP0jeYTWWaUI
         MeE6SgTJTPiWBhC9AUU5hmVaAXjzy50bPM6LOV17JjqC+4inRl/4yDJxVhRxuDK40T5A
         vGvZhmz6TCJp+zWhB42LV9spfusWTm3gQ9YT7of8ECrFocRAwvhVwM0uOZ6rJaD5eZkE
         XJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623749; x=1794228549;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8NTQB3dN2QpIdebJsLSmUNNG/IYt0L9NmfBKr3dfDw=;
        b=zzDlPayYVrgwv/RUjrtMOJYCk5jP88Un1jIGsRNXUDQiFdlkwqKesd3gVFZtmGLS5h
         QTv8mRDLuG92gemvZJgehWJr1JbXUf3xjYWhDHY/RlGCNDVSy+nLBY0PdhuBvGugS0X5
         Gv/rWk1DSVEHwlWOo+bLJ6lp9HDhopHGyeAmm7um00JsANaKCBZltNu9TYd7R3qLJIqf
         8ZGHe9TJ+NNJj74hSgtWmbWbByU95gCql5CuNa7m2moXwincFq8LPm1PEyDSrjIlEwl4
         5F1E+SnLdp5+LQuFaSOX9CqsyoslOlKYiiNJxQQrPipCn0g1oz93RiGjjWZSQLD0xoFY
         opzw==
X-Forwarded-Encrypted: i=1; AKwUvByl41uZGf8DmU1YwQ1+InruOMiJ3G0IfMwYFrl6ECmm1+qOSr1yyynLH6RHzt4rtl5Hp+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MgcBX5oWIGlyH/uDh213bF9dPtuqu+xKbHcjdEQgpoWJ8xNNK
	YFjoiTb4/8UegXCUkojBK1LPwtR17du0EPHsMO852fHROCqo+Et904YsCGcI/jbF02M=
X-Gm-Gg: AYBFou3g0Ot9DzMy/truEvHBgdgIEgdWfCu2qXMU59U4ok8CZOdNAy9Pmcq43zeL9n3
	XdP+yj6NuEnSQ1BK2kWe/mn9zbrD95wIOIWOzfkbHPUSh83686XfovWsMhRBQsI70sDpf/sZ10g
	yKVDbclUQ3ixAujmif52wANn8MgkwWmwClBMa4+G2Y8uF/4q4rWYObBo1wg0A95SPB+0xVeJ63i
	+mhkK4Gth+CvZD/eXUkYsQHZTtUXgbxqy7EzGYp9+vzixUOXS04IxtUEwTTSXjAb9VMJOOnvULn
	LcfuaNBxUBa4zOiUP9ynpI9zxS0b9NdGZDQr+bQMdTAeV89nPw+dYtAPKhiuJjb+CzupFzJg11G
	MWHs7m/YiiSKbIYpfmENMNVs7vK7alKbrovBt8SN+acgQx0fXSS6CruqMXHeiMRlYXelLnjRbjt
	qMpP+2UjVqTgIiDhfBKuWX1LDUICG3YbRd3oGFA/jOD6/lLT3WOXk/lCTtcdql40IPvpLK7votx
	Szgnoy/Rj5Erkz/JgJ0s2ajuC+/+6/X4tkIHKvZ8YWNttqFclUqzkZCbOcbl0OIfhUVUsZUheJb
	FcmygDrCCHHQ/wiugNRadKiqw3AKy4UjZvp6auw=
X-Received: by 2002:a05:6512:158d:b0:5bf:e799:c7f3 with SMTP id 2adb3069b0e04-5bfe799c920mr1589103e87.61.1793623749527;
        Mon, 02 Nov 2026 04:49:09 -0800 (PST)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe04ee003sm1638014e87.7.2026.11.02.04.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:49:09 -0800 (PST)
Date: Mon, 2 Nov 2026 13:49:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 10/20] ctlv: Prepare event queue support
Message-ID: <auiGL-Xq72i5K8FT@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-11-jiri@resnulli.us>
 <auCbPdoaMq9oWoQ_@e129823.arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auCbPdoaMq9oWoQ_@e129823.arm.com>

Tue, Oct 27, 2026 at 01:38:21PM +0100, yeoreum.yun@arm.com wrote:
>Hi Jiri,
>
>
>[...]
>
>> +int ctlv_event_emit(struct ctlv_op_ctx *ctx)
>> +{
>> +	struct ctlv_device *ctlvdev = ctx->ctlvdev;
>> +	struct ctlv_event_record *rec, *next;
>> +	struct ctlv_file *cfile;
>> +	u32 len, wanted = 0;
>> +	LIST_HEAD(spare);
>> +	int ret;
>> +
>> +	if (WARN_ON_ONCE(ctx->file))
>> +		return -EINVAL;
>> +	ret = ctlv_event_finish(ctx);
>> +	if (ret)
>> +		goto out_free;
>> +
>> +	len = sizeof(struct ctlv_event_hdr) + CTLV_ALIGN(ctx->output.root->len);
>> +	scoped_guard(spinlock, &ctlvdev->events_lock) {
>> +		if (ctlvdev->dead_announced)
>> +			goto out_free;
>> +		list_for_each_entry(cfile, &ctlvdev->files, node)
>> +			if (test_bit(ctx->op->event_index, cfile->subscribed))
>> +				wanted++;
>> +	}
>
>Suppose at the time of here, the number of subscriber is 1.
>However, before calling the ctlv_event_deliver(), another task hold the
>event_lock() to register new subscriber. for example:
>
>
>Task 1 (emit)					Task 2 (new subscriber B)
>
>wanted = 1
>unlock events_lock.
>						Register subscription.
>allocate one record
>ctlv_event_delver()
>
>  grab events_lock.
>    Deliver former subscribe event to old one.
>    new subscriber B will call ctlv_event_queue_event() with NULL.
>
>When this happens, new subscriber B would receive overflow event
>via ctlv_event_queue_dropped() though it was registered right before.
>
>Is this intended? It doesn't make sense that subscribe B receives
>the overflow event in this situation...

Not intended. Will fix.

>
>
>> +	if (wanted) {
>> +		ctlv_event_copies(ctx, len, &spare, wanted);
>> +		ctlv_event_deliver(ctx, &spare);
>> +		list_for_each_entry_safe(rec, next, &spare, node)
>> +			kfree(rec);
>> +	}
>> +
>> +out_free:
>> +	ctlv_event_free(ctx);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(ctlv_event_emit, "CTLV");
>> +
>
>[...]
>
>Thanks!
>
>-- 
>Sincerely,
>Yeoreum Yun
