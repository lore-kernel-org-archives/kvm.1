Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6EB30FF32
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517599; cv=none; b=qIzowGl5J7rO2tigsJIE6g75V5UBB3a7SWPcmxSg+eUywXmNq0DEzcqO1ZcrxL7yWaLI+34JTru8cAS8dqVEn/hb05t9ww+CuqfdK3Xyk7jkoMO5F9saZB27MyiRMafHsDyAVNleoZFKlys8BysEaoV/FikB4f1YMRyduhIU1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517599; c=relaxed/simple;
	bh=JSi5LjkR76txsPyakVLmmA8nchrLec+P9BgBPbcaXhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pknSroKOfEli0fMiajvesYv/1ybWxr1JDA441q/qoX/LO+73M0agEFEpzaQlkpbPpwQbb96k2px43u7WMFTI1U74aMfWr3GNnOc5BpueEHDF/6DJR45oopiq0dQlx6b/ID4yYD228q3qAFa1Tzvr0wiZmGBMiRITiN6NSRVX2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQkRCLyg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQkRCLyg"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2611233a12.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775517598; x=1776122398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HzzZacCRYi94tMXMTYIuvOMhPahDnXa/u6r4ttErhk=;
        b=tQkRCLygTCtWTb+9tw0dYYw74XmjIe2kXWwUHQd9+KRVy3vTBeUOqCmHp79OYDPZiJ
         zgugG5bH2dcOKz4W55Cc4+/i73O/VcOx7wLrWa8ITWr8TKp3JwA6ZhXv+U7ehXIE+4yN
         qDdAkiiFLLPgdBBg+c6c5c684RDb/BRLp/B9TOlKzWhpzS10H7cV3DWiDu5bu3pOtovg
         EBSZT9qZgQVr9un9UkPtpjkihAbFPydQXxilwf491YbZYqGBhtVFL+QSIKfvQDjX7nby
         aL+qQ/HPUs03/n9Qd25J0X6v1nLddloqLzOyU2CC+h7dpjZVaQK1VN3N1DXsTvFXs0Bq
         RZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517598; x=1776122398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HzzZacCRYi94tMXMTYIuvOMhPahDnXa/u6r4ttErhk=;
        b=bsUh/QorJvyJF3RZcQJa/y6ZBoUwybbY+LrvmA2KkvM/bOo0qjKa4FhjSICwQwacED
         PRvwO9f7ijP/TJRQYDsPDNM3N/Ej6Pc+Ybyj/5pzn/5NBCUcWUD4g1dI3jjfI505UIK/
         yplTyual/QfmhR+ypzpC4jNLguCzLuSaPUoGXaSVLF+xOYpYzhP6HlcjgTE2krHlrgd9
         jJOGQK0QDPYNYFtR2YEkRpO+zJoRZgxW6G/SSVmt5b1OO0+lvvcSCAG+4ho8BFHtUWmC
         9+skid5fDV9B8UDHFHBNKfuqF4MYfoyrJ+CRuvtvWLX3DSnqgIfUDRvkyLK83pUjrk7b
         v+hw==
X-Forwarded-Encrypted: i=1; AJvYcCWq3makwgkEGwad6+R/NJ2V1KcbCyvfvLl+JSOhSwh6ccaUJVBSYljVL6IHQnRQ9lpk44k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2OONz4hCXmseBIRoDqGJEuKr+U7hJH47FN6Czbp4RpAaHa+G
	/hClgjXJxDoMvlSCxBPrTlRF3MFiXlbwH2510ZV2TJJKVC25Juanmqw2bTzgQiiTZQ==
X-Gm-Gg: AeBDietICOIJZRUCmbdzasE9BD6yaJvt8dpGmznhFRiU9Uq7WkHAdHeaMFh0mB59ciG
	6aGYNIM1VRvfCQr3tev1QTCONwH4JbVl31Z1JzX7CqCDHyvFxCkyb3YYbiwCb11i75OIUpRGR+s
	ItdspeqrQ6vuT2CEhEe4scmZQhaRAQi59k/H0Zn2N6DbwhTOnfTtbS3KGtF+k5ixf8xZMhnoMFB
	VY/kq1s722OpFfa8w/itPjIfrXu8+UMJjfbtg/P0n58Quk5peAkE1eONthNy4ugVX34DXIGwwXU
	zcVW4DjJmpEJjknDHRcNm9Y/h7V1IXeVJCaDgMsrSvCVslMyP+Ur8wHs3U65WBG51wU/5WSUdBQ
	YOtsViCVGcvH0FomhbFSqkqTYAdj+oZkMEVXWDrC/Z4zzHq5FN5QzwJUDE8zQNikG78bvdi9a8r
	hKx6FR2LL/nbAyQVJJHp0KwWpk+zQwfL36u/A9y9TDAwLvon5yrU0RYn28/VQfBQ==
X-Received: by 2002:a05:6a20:12d1:b0:39b:8ed1:eb4f with SMTP id adf61e73a8af0-39f2eec3ca8mr14985907637.24.1775517597360;
        Mon, 06 Apr 2026 16:19:57 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65995a9sm12981866a12.27.2026.04.06.16.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:19:56 -0700 (PDT)
Date: Mon, 6 Apr 2026 23:19:52 +0000
From: David Matlack <dmatlack@google.com>
To: Rubin Du <rubind@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/4] selftests/vfio: Add generic PCI command register
 helpers
Message-ID: <adQ_mA6bJI03CagI@google.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
 <20260403234444.350867-3-rubind@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403234444.350867-3-rubind@nvidia.com>

On 2026-04-03 04:44 PM, Rubin Du wrote:

> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 2858885a89bb..e5e290eed510 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -65,6 +65,16 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
>  #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
>  #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
>  
> +#define vfio_pci_cmd_set(_device, _bits) do {				\
> +	u16 __cmd = vfio_pci_config_readw((_device), PCI_COMMAND);	\
> +	vfio_pci_config_writew((_device), PCI_COMMAND, __cmd | (_bits));\
> +} while (0)
> +
> +#define vfio_pci_cmd_clear(_device, _bits) do {				\
> +	u16 __cmd = vfio_pci_config_readw((_device), PCI_COMMAND);	\
> +	vfio_pci_config_writew((_device), PCI_COMMAND, __cmd & ~(_bits));\
> +} while (0)

Whoops, missed this in my previous email.

These should be static inline instead of macros.
