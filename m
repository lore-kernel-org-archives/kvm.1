Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366283F3286
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752634; cv=none; b=ZUpJYYtIO2gcrGfIiDYe1laf/r68WwN/SNtfFINiMOwsr2afknSTbyBHHfxEIu1pCj45KmHTqKNwfAazBE3hF8ajW8JVPNrjIDcEznnLmKMJ+VPswi7IimDyiRe9wOMcAz4qvl00cpfAgeMejthw/xNsnmq1yqFVz2gJvYf6u8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752634; c=relaxed/simple;
	bh=t+OEjDwIunpqVOnbDXkVoH6xLQrzgAaRW9ZMUYdvpsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSJwAi5iR5CEdlWofM/uUQLKYepakgUOs99lupvq5e3iaUp848kJERpVxumShBbCTAxaXkABUMCIf+rkQi5KDgRbJn0ataiq3HErrdBFxr6we34n25vW5OW+26pvW0C8pvbcuDRf/grAMgPMqmIUZjqSEmLKASuGvS8zSk7Wp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IF83l4gs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IF83l4gs"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2020421077so150304366b.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787752628; x=1788357428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fOvJ5L5msgiM0CBERBT0U46KkGHdEod8CtevSmc1gXQ=;
        b=IF83l4gsNR2fnVQjSoF6YcozKGcetBmY1Ec0eQh3ZlHSnEoqpPcE1qJpa4YjXvjM/V
         +pHbmBChPNjaHYz6ukGEm5KHMluUUjYpczVEOMJHlt6ga0vcalY4+W1PYjrKoC5d9Vlb
         A8Cw8xDFRc2uce4xPGjjJMeRmZIo/x362+UEk6jIf4Ii8n0zNhuE4JFbOtY2W67oUraz
         y/hHC4LfRarai0rslC6Q53oVdxBzSSZlQJ5Yj9gf0GNdkFdn5mAVp1e2tSIkHAQPqKRN
         tuFK7Wvi2KRr5aKlHa3x7+2uKOJJYxwrrKWDAAiIpxSN4EDfHzC3Dvut1KScnHqMp0DJ
         WVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787752628; x=1788357428;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fOvJ5L5msgiM0CBERBT0U46KkGHdEod8CtevSmc1gXQ=;
        b=sNiIAyleZAMNqfb/CAiQVF4bd+OB6xZgKOUZxkFHb+2z7tbuUCLmqy/swXxicoJ02f
         TLdKds4ETjj0HBSPpt5VMuNaJdqz/Z59OSBrxBi/hxbuIx8TJiERkOAeCqTv5Fc4Xkx5
         XAgw/TU7s0rrFWEC0zQo75t7+iSQTWL6H+A6aQ4uI/09o7ia72/TuyL/al6mOa76CDkE
         wd40L260FZ/h5Gm6ZTain4dxTjxIsHgKKocWpBjBYvj+L+yyc/rbYPSf+9a45rD5vbdq
         /xgxw49xHTWY+RobJC5kp+sIoMD6s45U8E/rCMPw1KKGDMXi8rofmdcugdEgvJGi63Fv
         EtDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFexWZmrRQSOekN71FG6Gb6u720heHkksyJAJ+R878NKDhqJH1PFRea9W5/uolo9Is5L4=@vger.kernel.org
X-Gm-Message-State: AFuF++lTDbnODCtljJ5qFQxao0kJTmBaH4k9n33l778VYq7a9ksQjYXA
	aGPxKXXhvsMdCEL64YarPoRqiWpzvA/ev2ZmjLTb9Xnn8lOJoVgzy1fukbaz+IFHDA0=
X-Gm-Gg: AR+sD12oABGXNJ3CsoyrWtoHUw23LmdJS61drisEaEAqlZzCN2ykNpjdqZnk8XP8+zY
	EYiuC+O8ouyUjbVr1S/96K9qQBigv1r8iV6sljwE65NUhU7EINQiGll11fIRmQfL8+tS+wAnrI7
	G2BXVGdQ5+mn8DG5UBeZUmCFmdwq1bGU55keawWDckTwvxSgNAOKIl7GhKC67l6BNkpZ4bO8JmJ
	PV2jb8Pcl+ugCN21e6hOM2hy5TvUQgrW69QN0Q4uoPi27XFD1F+AjcdmzDvnsjXwvHHYpsRUWLw
	NJBgyIUT3Bvl6QfAB5v3UZF09A70Ysrc77Z7Hl9+linBpzrgv0Un6aEj++EiqR1YJh9UT+gTrWR
	qjrecYeQM/AtqNZPEib7DWFrNjL0VTbVzoR3noeJh5XtKtrS+bFqL7kco4jh+arof8xTVAjHKQy
	5hikI3gF2lI+lxff0kmDGEhhfMEKfIPMSeXQOJKkBBi2Q5uPJqBfGWk3CxiPKvCqw=
X-Received: by 2002:a17:906:628b:b0:c16:66dc:3ab7 with SMTP id a640c23a62f3a-c250c4f025fmr802637466b.10.1787752627642;
        Wed, 26 Aug 2026 06:57:07 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a7303casm680099266b.25.2026.08.26.06.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 06:57:07 -0700 (PDT)
Message-ID: <1a720dbf-7500-4a35-a069-3561a9f08c0d@suse.com>
Date: Wed, 26 Aug 2026 16:57:03 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] x86/virt/tdx: Wrap TDH.SYS.CONFIG/UPDATE operations
 in helpers
To: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: kas@kernel.org, rick.p.edgecombe@intel.com, yilun.xu@intel.com,
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com,
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com,
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-2-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 xsFNBGcrpvIBEAD5cAR5+qu30GnmPrK9veWX5RVzzbgtkk9C/EESHy9Yz0+HWgCVRoNyRQsZ
 7DW7vE1KhioDLXjDmeu8/0A8u5nFMqv6d1Gt1lb7XzSAYw7uSWXLPEjFBtz9+fBJJLgbYU7G
 OpTKy6gRr6GaItZze+r04PGWjeyVUuHZuncTO7B2huxcwIk9tFtRX21gVSOOC96HcxSVVA7X
 N/LLM2EOL7kg4/yDWEhAdLQDChswhmdpHkp5g6ytj9TM8bNlq9I41hl/3cBEeAkxtb/eS5YR
 88LBb/2FkcGnhxkGJPNB+4Siku7K8Mk2Y6elnkOctJcDvk29DajYbQnnW4nhfelZuLNupb1O
 M0912EvzOVI0dIVgR+xtosp66bYTOpX4Xb0fylED9kYGiuEAeoQZaDQ2eICDcHPiaLzh+6cc
 pkVTB0sXkWHUsPamtPum6/PgWLE9vGI5s+FaqBaqBYDKyvtJfLK4BdZng0Uc3ijycPs3bpbQ
 bOnK9LD8TYmYaeTenoNILQ7Ut54CCEXkP446skUMKrEo/HabvkykyWqWiIE/UlAYAx9+Ckho
 TT1d2QsmsAiYYWwjU8igXBecIbC0uRtF/cTfelNGrQwbICUT6kJjcOTpQDaVyIgRSlUMrlNZ
 XPVEQ6Zq3/aENA8ObhFxE5PLJPizJH6SC89BMKF3zg6SKx0qzQARAQABzSZOaWtvbGF5IEJv
 cmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPsLBkQQTAQoAOxYhBDuWB8EJLBUZCPjT3SRn
 XZEnyhfsBQJnK6byAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJECRnXZEnyhfs
 XbIQAJxuUnelGdXbSbtovBNm+HF3LtT0XnZ0+DoR0DemUGuA1bZAlaOXGr5mvVbTgaoGUQIJ
 3Ejx3UBEG7ZSJcfJobB34w1qHEDO0pN9orGIFT9Bic3lqhawD2r85QMcWwjsZH5FhyRx7P2o
 DTuUClLMO95GuHYQngBF2rHHl8QMJPVKsR18w4IWAhALpEApxa3luyV7pAAqKllfCNt7tmed
 uKmclf/Sz6qoP75CvEtRbfAOqYgG1Uk9A62C51iAPe35neMre3WGLsdgyMj4/15jPYi+tOUX
 Tc7AAWgc95LXyPJo8069MOU73htZmgH4OYy+S7f+ArXD7h8lTLT1niff2bCPi6eiAQq6b5CJ
 Ka4/27IiZo8tm1XjLYmoBmaCovqx5y5Xt2koibIWG3ZGD2I+qRwZ0UohKRH6kKVHGcrmCv0J
 YO8yIprxgoYmA7gq21BpTqw3D4+8xujn/6LgndLKmGESM1FuY3ymXgj5983eqaxicKpT9iq8
 /a1j31tms4azR7+6Dt8H4SagfN6VbJ0luPzobrrNFxUgpjR4ZyQQ++G7oSRdwjfIh1wuCF6/
 mDUNcb6/kA0JS9otiC3omfht47yQnvod+MxFk1lTNUu3hePJUwg1vT1te3vO5oln8lkUo9BU
 knlYpQ7QA2rDEKs+YWqUstr4pDtHzwQ6mo0rqP+zzsFNBGcrpvIBEADGYTFkNVttZkt6e7yA
 LNkv3Q39zQCt8qe7qkPdlj3CqygVXfw+h7GlcT9fuc4kd7YxFys4/Wd9icj9ZatGMwffONmi
 LnUotIq2N7+xvc4Xu76wv+QJpiuGEfCDB+VdZOmOzUPlmMkcJc/EDSH4qGogIYRu72uweKEq
 VfBI43PZIGpGJ7TjS3THX5WVI2YNSmuwqxnQF/iVqDtD2N72ObkBwIf9GnrOgxEyJ/SQq2R0
 g7hd6IYk7SOKt1a8ZGCN6hXXKzmM6gHRC8fyWeTqJcK4BKSdX8PzEuYmAJjSfx4w6DoxdK5/
 9sVrNzaVgDHS0ThH/5kNkZ65KNR7K2nk45LT5Crjbg7w5/kKDY6/XiXDx7v/BOR/a+Ryo+lM
 MffN3XSnAex8cmIhNINl5Z8CAvDLUtItLcbDOv7hdXt6DSyb65CdyY8JwOt6CWno1tdjyDEG
 5ANwVPYY878IFkOJLRTJuUd5ltybaSWjKIwjYJfIXuoyzE7OL63856MC/Os8PcLfY7vYY2LB
 cvKH1qOcs+an86DWX17+dkcKD/YLrpzwvRMur5+kTgVfXcC0TAl39N4YtaCKM/3ugAaVS1Mw
 MrbyGnGqVMqlCpjnpYREzapSk8XxbO2kYRsZQd8J9ei98OSqgPf8xM7NCULd/xaZLJUydql1
 JdSREId2C15jut21aQARAQABwsF2BBgBCgAgFiEEO5YHwQksFRkI+NPdJGddkSfKF+wFAmcr
 pvICGwwACgkQJGddkSfKF+xuuxAA4F9iQc61wvAOAidktv4Rztn4QKy8TAyGN3M8zYf/A5Zx
 VcGgX4J4MhRUoPQNrzmVlrrtE2KILHxQZx5eQyPgixPXri42oG5ePEXZoLU5GFRYSPjjTYmP
 ypyTPN7uoWLfw4TxJqWCGRLsjnkwvyN3R4161Dty4Uhzqp1IkNhl3ifTDYEvbnmHaNvlvvna
 7+9jjEBDEFYDMuO/CA8UtoVQXjy5gtOhZZkEsptfwQYc+E9U99yxGofDul7xH41VdXGpIhUj
 4wjd3IbgaCiHxxj/M9eM99ybu5asvHyMo3EFPkyWxZsBlUN/riFXGspG4sT0cwOUhG2ZnExv
 XXhOGKs/y3VGhjZeCDWZ+0ZQHPCL3HUebLxW49wwLxvXU6sLNfYnTJxdqn58Aq4sBXW5Un0Q
 vfbd9VFV/bKFfvUscYk2UKPi9vgn1hY38IfmsnoS8b0uwDq75IBvup9pYFyNyPf5SutxhFfP
 JDjakbdjBoYDWVoaPbp5KAQ2VQRiR54lir/inyqGX+dwzPX/F4OHfB5RTiAFLJliCxniKFsM
 d8eHe88jWjm6/ilx4IlLl9/MdVUGjLpBi18X7ejLz3U2quYD8DBAGzCjy49wJ4Di4qQjblb2
 pTXoEyM2L6E604NbDu0VDvHg7EXh1WwmijEu28c/hEB6DwtzslLpBSsJV0s1/jE=
In-Reply-To: <20260821032920.256225-2-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/26 06:29, Xu Yilun wrote:
> As part of the TDX module initialization, the kernel configures the TDX
> module with several information, such as TDX-usable memory regions
> (TDMRs) and the global KeyID for protecting TDX metadata. During the
> configuration, the kernel does 2 operations: constructing kernel data
> types for the SEAMCALL leaf arguments and turning these data types into
> u64's according to TDX ABI.
> 
> Both operations are implemented in one function - config_tdx_module().
> This blurs the boundary between kernel managed structures and TDX ABI
> definitions. Moreover, future kernel change will need to add more
> nuances mandated by TDX ABI, such as setting the TDH.SYS.CONFIG leaf
> version to allow configuring add-on features. Keeping these operations
> tangled would further clutter the code.
> 
> Just like other SEAMCALL leaf helpers, wrap the invocation of
> TDH.SYS.CONFIG in a helper. Introduce a more descriptive kernel data
> type for the physical address array of TDMR information. This data type
> is similar to struct seamldr_params in that it is the container of the
> PA array layout which is an in-memory ABI. So the previous u64 * type
> for the array is not wrong, but a named structure provides better type
> safety and self-documentation. Use the data type as the argument of the
> TDH.SYS.CONFIG helper.
> 
> Future kernel change will also need to set the TDH.SYS.UPDATE leaf
> version for the same purpose. Add a similar helper to prepare for the
> change.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
