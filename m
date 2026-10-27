Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096254;
	b=hb1jruEe6oG9Z/gvHIY7nIwE16jrCy6vRnqzjFstSky7b5umqSvF3PRCG1X4+GSFJBkN
	 4ce4J7M5pwmSl9WqSgfkOJKAAHzc2nnH2FToSeahRF/AoT7QtCScdmWJgpvjmHVY9rMV4
	 jqr9vZDWGg054msZi5G2O4CKmGXHxxXwx8mL/uj8k+N8fonTHwT6xsXtddC4yK7Rx1R6/
	 KhYgO0YyZkeU6qjz2nr2+vVkGDfgW9hAXWYIz8ErHOLPimWOVIC4/4LEchhi9+Bmpjzbl
	 Snvav827JpkS5/XxCCqm1Z2IvimrokO2uiJHrUMv3u11fm6steq8YInyp1DfR38A8PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ROl8Z/DFaCJAxQvsLDCIwxAYaCdKritEmYyIuCU28LM=;
	b=qBsUCECqFr0G5QmmIUtvlEGxBwcn4EE4PkB0ZfiGS7NlH/ngEOezFOgsmIHb+8xRatWQ
	 1+sqXe4kUT38ZEZlNx/RuWIiDRZlpA7vC77bZmckXcO9xtREbxnF0EFKePrQIkTyMxkA9
	 0CCYNhonQ6NzqzioUJ6nyR+5X7l+CEpXMlkZb15F4wLac5/rXmF2gJUIzcgq4Q3aGZfQj
	 m30QmCA2BDpWOQOEdzw0yAjAjKqfXb6qg6VUQc9xoa1Lh5OvHIcrOL3V3cZ/8Ft2h7zLZ
	 7cQt7D0dYaoAodfN0tkvjiqqgC3aJQi5F+qpUglFoiy6WVHoaPdsJLkeFK92/Oc4pIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=fmA5ZVtw;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147F606A32C
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 10:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D147F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=fmA5ZVtw
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso40907495e9.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793096251; x=1793701051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROl8Z/DFaCJAxQvsLDCIwxAYaCdKritEmYyIuCU28LM=;
        b=fmA5ZVtwVJcNE/fAKAHqsP3pTMhIMG/B4/fp3GRzy6U2KUaRfKgSPPQRO7kH3SZ6uV
         l+fzzhfmGr9Mctm3db6DzPN2NeHVOu5pYzT1nPmjh7/grQz1Dup/ibheJflAfN28BYGt
         sbIOe1LMk8vFbragFHLOaRICCrM6OPu2imRyfnGBgaurj8ZgT/B2EU27xE/StHY2p3vI
         0FtODpcVTVfduuEmzZ206fQ1o2SEoqVEe0oCCy1muVMUaUmDeCS4IvdMx8Y+6Yayv+xv
         4MfvlIyEMIM0RMDLyW4wNgG61M8b27rM8mXK+xBP7O+Jx/KNHvVSN9NnsB2j6/T8iqaN
         ieig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096251; x=1793701051;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROl8Z/DFaCJAxQvsLDCIwxAYaCdKritEmYyIuCU28LM=;
        b=bSf4kWTJeQ21PKZ/uFLee72MEVJ09f7H0CxfyPX1IGFR9mv0m25eXTA3Rfn8Fmros+
         /tvF9GQuhMrQkpZYggBP/XjT4RMJ+IJYk2Vc1tygSnX4shCpbPCz+9OzTh+88FL9829+
         Mqx2G7sdYNkwrOHvJgGdPHKsaBWRaoQPu6T9o/j8i5udceMw7FjIDLWyYowG+Dgma71O
         bpK9nEDRXWpEZnMG1qIhhLUaL8ByfBIWCOWSr7RFGpSrzIUssb589SJBjwjQV5IMG+EK
         LULTIHyDb7fgp4QaIomLdkniE2RDMWrE/NlP28Jw4Rrwq7nXDRjnzY3+MpjMPUJSBMQf
         6l+w==
X-Forwarded-Encrypted: i=1; AKwUvBxX2YKfo2guHkWBCmC/3g/ddKBWg/KIAug4xpIm0YcuuO7HI7thc5X87ZZVoe6kLRCwCB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqrRQFA2hQb4LAu5hrVPAl7Y62Oyh1eNlorHYHmrIOBPyh7yYq
	mrkwq3yqJikNk0mItrWugc8oYPNrAw9/Nij3p84iyid6gB7StejaGTBnzQEfvjQU+ww=
X-Gm-Gg: AYBFou1cfGc4yRQjG/yUYYX5msabLnCS1vynTtcIGu4xG0BqzgZTeHGip7pd6PIhwvJ
	nITsvNqB4DrRBnsCT8HSIMaIDhSX57JA2TOv9JdeZzcP6PWwM7l/0fCtmchoP9TVG7QIr+f04r9
	ZI6YSGt8cn3MBi9Qrq1R9q1nyzk8DXDFOyiffO6AeQXsrX0mOXOABbl7T+K+dIJR1gfkei2h0M5
	qStNvFsfHpr7EwM3OPLuqTxkMKhbJx1pAF3EeGrOGEOBrq0JGENRoBEBcht59QSRFR8ES671TJf
	MAVZwtRIVnpV8S1mX6emDyV6l1bgbOQnwC6StU1JAexTBBXR70q3ojWXGK8keOhLT39TaA2w6PI
	zgEL2I/sUQggk9ZGGDsk4Ul0/IxMdYr9CCbpLZqfDkIXKawa4ZXF8tJlGoseyvT64dY4oZJ2W59
	tkcpEqWBCVzx36wvaKbxuJ5xTij0OYtGlzy2vX+8RlDDsAfPX+5Gt7dvSc13+RtlkTpDWxvC1R3
	z1c0E+izrXJvGaFHep+TgTRwF9CMLmVsUB5VFVTHmIqCEFb+yU1cLmcJKaqIhj6
X-Received: by 2002:a05:600c:4704:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4a35acc2ea1mr170116035e9.35.1793096250940;
        Tue, 27 Oct 2026 03:17:30 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2ed5a2sm271453735e9.15.2026.10.27.03.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:17:29 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:17:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	jgg@ziepe.ca, david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, 
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 05/20] ctlv: Prepare message input handling
Message-ID: <auB5yxcuA50kg5x4@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-6-jiri@resnulli.us>
 <179302367449.58760.13616210130636541456.b4-review@b4>
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
In-Reply-To: <179302367449.58760.13616210130636541456.b4-review@b4>

Mon, Oct 26, 2026 at 03:07:54PM +0100, jgg@nvidia.com wrote:
>> [ ... 38 lines skipped ... ]
>> --- /dev/null
>> +++ b/drivers/ctlv/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menuconfig CTLV
>> +	tristate "CTLV character device TLV UAPI"
>> +	help
>> +	  CTLV provides character device UAPIs described by a checked-in YAML
>> +	  specification. It owns the character device lifetime, the strict TLV
>> +	  message format, request validation, reply serialization, the large
>> +	  payloads a request describes rather than carries, per-open event
>> +	  queues and runtime schema introspection, so families only implement
>> +	  semantics.
>> +
>> +	  If you don't know what to do here, say N.
>
>This should probably just be a simple selectable config instead of a
>full blown menuconfig. ie one with no description. Since this is
>really just a tool for subsystems to use every subsystem that uses it
>should just select it.
>
>So:
>
>config CTLV
>   bool

Makes sense.


>
>
>> [ ... 159 lines skipped ... ]
>> +static bool ctlv_message_nest_index_ok(const struct ctlv_cursor *nest)
>> +{
>> +	const struct ctlv_message_input_index *index = nest->msg->index;
>> +	const struct ctlv_message_input_nest *indexed;
>> +	const struct ctlv_message_input_scope *scope;
>> +	const struct ctlv_attr *attr;
>> +
>> +	if (WARN_ON_ONCE(!nest->msg->request || !index ||
>> +			 nest->index_nest_scope >= index->scopes_count))
>> +		return false;
>> +	scope = &index->scopes[nest->index_nest_scope];
>> +	if (WARN_ON_ONCE(scope->nest >= index->nests_count))
>> +		return false;
>> +	indexed = &index->nests[scope->nest];
>> +	attr = (const void *)((const u8 *)nest->msg->root + indexed->offset);
>> +	if (WARN_ON_ONCE(attr != nest->attr))
>> +		return false;
>> +	return !WARN_ON_ONCE(scope->tree != nest->tree || scope->node != nest->node);
>
>Maybe wrap these invariant assertions in a helper and we can compile
>them out?
>
>  #ifdef CONFIG_CTLV_DEBUG
>  #define CTLV_ASSERT(xxx) WARN_ON_ONCE(xxx)
>  #endif

Well, yeah, that would probably make sense.


>
>It helps manage expectations around WARN_ON. I assume these have all
>been checked to guarentee they cannot be triggered by users space?

Sure.

>
>-- 
>Jason
