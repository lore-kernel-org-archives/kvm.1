Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC573F164A
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726256; cv=none; b=syGECtzfIcf+8jDv3q/ZTYXMDb1t7iksf+99LJVfC0SSEsZGpB3TG6Vu91zZfUrkZOYEUIsSokUgvem1Q0+tBdKL/qjDev2sOOSqHBrs3nFhSuMrZ6LHRI5R9P62kax6o7Q1lKp4Y/xHVF51fVOtTE3rLNS5PxVT11kXmw7h0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726256; c=relaxed/simple;
	bh=Ix5V9VVReiSoQo6AB3QETxLfhu0cCyAdGQjvJGHnDxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srFebzD2cwf2OBp3GUVoit8qp9rud/IXAsMjuE9K8t0lG889C8yvLRUkcJC8GluRlNsAYUVrzODFP5sjT01++GrjmPT0FpPflfUTBgONTf6a5U1Gvf7wwxgkrJD6kILkqz0zhhuC+SydpOOg2ig+Zyw9VD/qokQM+l5o4RqlSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VdZk1QbN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VdZk1QbN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d73422431so6868184f8f.2
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779726251; x=1780331051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WThGrJlj0+d9TTzzXLAp8aZigkvM5HszOOE/MfwSIgg=;
        b=VdZk1QbNytpFbuiKsbE3wW+kpdUiwO8Oy0pgmIL3aXlcs3cEHrAyW3jehgTlLTi83n
         wNh17lNTxLLkgF2MNP6aUmiJt0rCd+jWtZnbWylWlzXlbassqIWZOQCLLOffSEkhSbua
         +xQlxnJ9qX8lxTNaTtv21kd2cKIugw5nnDeVK3GmUj9N/fqumL9jVllnCfVPprFZDh/q
         LoGx1NaFUjwhYiOVtB2Bo+Ks5HuJmMsqFtXlcMGYkbS3CeNG7DthkcDMBrct+OJR510y
         SClO2VskO/kDqNdoapbvTguZijtUGevTSuelHBqTta1LS7zaFq3R8yRear0hL0uSsY1S
         vaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726251; x=1780331051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WThGrJlj0+d9TTzzXLAp8aZigkvM5HszOOE/MfwSIgg=;
        b=r252hWvS1oXbla4YL5nYeud0Qai8+0Ox2NPAzGtvPwX/jKoD79QYuwJaRQ6ZqscvBa
         4vOcO3yo3S4KY/8jqBeZBLRpaH1YeyuevxKVFyN3MogNMSIsGgXjCUCuVmvn2BsfMttE
         SpzVdtnzsSo1vS5coNaRpbqlmYZZtid3ai1GFJ4ia8w1lnQravyRupNhqJ3SfwkwRYnR
         ox0tYNcmE+qBhgYiXrrcEQ7euRyCco93tDqlRYyuQxLZOVbbg4qKm6Ngle04tlBYfyAB
         xGuX9M8j06USUuYszZjbYK5mm3KzKYrd6ikTn1W1JOQkLAgCPNrxe1R6zo+u/gwk/KBo
         DWfA==
X-Forwarded-Encrypted: i=1; AFNElJ87/JlmQFCAy9rouiEyR4M1jTwlKvlFWVZZopqPtZJXRcD3sVlZXsQPmwgy/j62gZPkGYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoyWcJGyQF/1g/JM9mdTkwn5BIcx9eON7tpv1FnhOqzWDsOVrT
	cI7OAvyAm3L5Uzn5zfCyuysBcayhIeUGu9rTP66TXv6x4jKLGw37C/QDNGeoSjY9p7k=
X-Gm-Gg: Acq92OFjYkmrzdcU3vCXWMNr0ZWP+RnAh5pd9ixKCwEc6Ntlyp36PcVbiY96TzNfOCN
	ro5YE97+tWynOQH5QvW/JF0MLzfjvrJaRSNWHArsDCjcbhoLzRcgykFJwgZV8g1Rae21TI01tOg
	nBtpcnoPANy/G5TB84zGZcO6MTaGQId6zESYdvhGGvWfIZemLARVVwDGVQeZpV1K0R/nb6qBka0
	0/WWCGM7FT4tmIg7zuxlbSsKmg+GVVaZ5/F1Pp/DVIIg5akMrDiQoNtE5oQbtd4sk0kJHxF3UFM
	uOVSxltOrbcBM4aGrKGZtbS3HV+Dw3+IO91e/SVSXycuAueISpB9Z5pVRV+s7aXZfK+Hlinw46k
	OF55WxWxNsJpRJUK2x2NS99xbsndKn9dUQWc+Ss+fB2tdPUN8jg96F7GnHUSsWwu4H0ba2v3odY
	EdeWgX+lzx1uEED2v7v4yVZoryFnrsIF+Ff57IdDgbb/tJFdHo6fmA8JaaPU8SKgLD+qireDFNf
	d8RRKdhAorGVZIMBQDWi7hWewdwjLcbIaZjj6wnxlKITeLl1WS9/Q7orF94+qY0zsvKiw==
X-Received: by 2002:a05:6000:26cf:b0:45e:b215:12e9 with SMTP id ffacd0b85a97d-45eb368903emr24724531f8f.6.1779726250728;
        Mon, 25 May 2026 09:24:10 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d47b82sm28202483f8f.19.2026.05.25.09.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 09:24:10 -0700 (PDT)
Message-ID: <4e54ae4a-4f7b-451d-9b37-97f30b8fefba@suse.com>
Date: Mon, 25 May 2026 18:24:07 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] moduleparam: Route DEFINE_KERNEL_PARAM_OPS get
 pointer via _Generic
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-7-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-7-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Make the DEFINE_KERNEL_PARAM_OPS family route their _get argument to
> either .get (struct seq_buf *) or .get_str (char *) at compile time
> based on the pointer's actual function signature. Two helper macros
> do the routing:
> 
>   _KERNEL_PARAM_OPS_GET     - return the pointer if it has the seq_buf
>                               signature, otherwise NULL of that type
>   _KERNEL_PARAM_OPS_GET_STR - mirror image for the char * signature
> 
> Both use _Generic; only the two valid function-pointer types are
> listed, so any third-party type is a compile error rather than
> silently falling through.
> 
> Now a callback whose body has been migrated from char * to struct
> seq_buf * needs no change at its kernel_param_ops initialization site,
> because the macro picks up the new type automatically and assigns to
> the correct field.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/moduleparam.h | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index c52120f6ac28..795bc7c654ef 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -85,15 +85,32 @@ struct kernel_param_ops {
>   *
>   *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
>   *
> - * Routing the @_set and @_get function pointers through the macro
> - * (rather than naming the struct fields at every call site) lets the
> - * field layout change in one place when callbacks are migrated to a
> - * new signature.
> + * @_get may be either of:
> + *   int (*)(struct seq_buf *, const struct kernel_param *) (seq_buf)
> + *   int (*)(char *, const struct kernel_param *)           (legacy)
> + *
> + * The macro uses _Generic to route the function pointer to the
> + * matching field (.get or .get_str) at compile time, leaving the
> + * other field NULL. Each helper matches the wrong prototype signature
> + * and returns NULL, falling through to the default branch otherwise;
> + * if @_get has neither expected signature the assignment to the
> + * fields gets a normal compile-time type-mismatch error.
>   */
> +#define _KERNEL_PARAM_OPS_GET(_get)					\
> +	_Generic((_get),						\
> +	    int (*)(char *, const struct kernel_param *): NULL,		\
> +	    default: (_get))
> +
> +#define _KERNEL_PARAM_OPS_GET_STR(_get)					\
> +	_Generic((_get),						\
> +	    int (*)(struct seq_buf *, const struct kernel_param *): NULL, \
> +	    default: (_get))
> +
>  #define DEFINE_KERNEL_PARAM_OPS(_name, _set, _get)			\
>  	const struct kernel_param_ops _name = {				\
>  		.set = (_set),						\
> -		.get_str = (_get),					\
> +		.get = _KERNEL_PARAM_OPS_GET(_get),			\
> +		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
>  	}
>  
>  /* As DEFINE_KERNEL_PARAM_OPS, with KERNEL_PARAM_OPS_FL_NOARG set. */
> @@ -101,14 +118,16 @@ struct kernel_param_ops {
>  	const struct kernel_param_ops _name = {				\
>  		.flags = KERNEL_PARAM_OPS_FL_NOARG,			\
>  		.set = (_set),						\
> -		.get_str = (_get),					\
> +		.get = _KERNEL_PARAM_OPS_GET(_get),			\
> +		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
>  	}
>  
>  /* As DEFINE_KERNEL_PARAM_OPS, with an additional .free callback. */
>  #define DEFINE_KERNEL_PARAM_OPS_FREE(_name, _set, _get, _free)		\
>  	const struct kernel_param_ops _name = {				\
>  		.set = (_set),						\
> -		.get_str = (_get),					\
> +		.get = _KERNEL_PARAM_OPS_GET(_get),			\
> +		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
>  		.free = (_free),					\
>  	}
>  

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
