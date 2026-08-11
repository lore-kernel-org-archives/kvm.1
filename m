Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88B367B93
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483316; cv=none; b=Ub1X184mP/xc/M37L9+g7Xbye/rR82995s9ckf3zv2i5BN80nxdYVqzvH5/nyk5tGf1h3yOAGr4xIvAuU+Y1asanqENlbNn+Hfq/6WLJ1cE66sOJ4PRS2zX8S67KvmSGgJ5DnSAdaVP1nSQmrfY2mav2P3QAyUFexdSTjlgITuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483316; c=relaxed/simple;
	bh=Fs1q1LuXAYTQ937j0F968WLbSfpvhN7jSqDN7Jd6uBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMcn4u1CuBJbo7bMvJ9latXKIS927JtQwE2OpJR7/llxG6MQcvq0wyIyCBjJJxtgzQGp7jN6HB5HvuqxiRPtMuuhe3/pMtHFe2eYQckp0vVtr4Zv9HDxMVzDKN/x7UIFftWDkz8gDHJb3THg/8uwmX/aQmZ+lJ9hdBPeKfUTrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oCnsIJii; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCnsIJii"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cab973140bso7123145ad.3
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786483314; x=1787088114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GgcKeBktnliFILPgH5Yp5qgxA2fPy6McTHeUrYz6elM=;
        b=oCnsIJiiAa+BgmeANSpLE+VLIkqqf6si5TmkXYqWUN7rwWASs+8tCFt8sDy9jf45GE
         dNZQHLhAJuuQ219/ZhzhV9yMo1LlFBPYZo90lR6Vj4S/c1yJ+ncXs7pC37Hibsaol2vM
         OZNpADAY7eNS5dxoHhjOMCAvS7K1rUa3m857YFfWUi19LDam5t19cwLQ8ggmCwBb7idD
         ZASg0IS3qgO7u+iiNRV4wdmUzVJHr9b+vT4jTUDYToVoL50OEPlT5rrc7NsGal0EK96g
         IhYKK4MXhwdw8ywAhnlhd5iEHD7LRmQwUFyXdxmmHfu4S5ktCLUSPmcXp98j9LYuTu/n
         7h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483314; x=1787088114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgcKeBktnliFILPgH5Yp5qgxA2fPy6McTHeUrYz6elM=;
        b=kmr4oJhvNkg5H9hyGgdc/2rNSzo4ny7QC8Hh098hfKF3HAFnfR9aHQp+x0IUkwSoOK
         VsWqcwuCLX62quScUIgRDNOJbC8lHGA31bObFCYKH27iUEu/WEEoVSRH2vLH8lZbd8K5
         sQBY6TP44n7s5syuRlOnxTrxCf58+6eX83miM5Rqpg3jHe7+1sQfGJ1BYVYbX1NtSigA
         WQpi0if65IfzdO9UAG9YgeTUivkUVpGQHRtLbvIsXHyNVl9sYEkjKUFPQT2TmEpz1JGC
         8S9N5yymTfMZYpB8M8qclxWn5lHAjG9TB5xCQk1OJE/Gl8C65/SC1eaVqJnkb5inLtSs
         6M0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpdDT7PaFrLnKnjG14Xh3Yvu1IZuQwZXorLYZBo2xbUebAzrKEJQKyNKo98Io768SsqdhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRG2tjil5S80a6KzKpRziJqhNKemaKRbQta//vToRxiHvAjynZ
	Rnwf6D1YrLVboDN+B/2zUNx+AlSGkLH3y11H1v3Hj+OWxIOYKeB/E99G5ILsz7prkg==
X-Gm-Gg: AR+sD12kGTJZrE6s7Ma6bxaks5P2nlVPWFmBdsvtyqtzoQNKaZ3fnO33ABh1CSV5wzr
	4YA/f26f0Mtze8ea8VfNdQWDYt4Yv4FHIX1BACiudYMs4qwxxE4IB1W5kzCBd1kL439AM3w9Lea
	uhx59Q2lyikRDs9f5zXvSoWWnY5Sk3m+CONkqweRS9K7qzzS+gXNdI8TcXOKtqunnW3mzMPQZe4
	3zpMHEs9lNUNYOihpK1nkTxtapFSkCMag90u6DA9C0xXKgXbMjyC7q8YyvqIvJJh2GYCWTdWuMT
	J/VvZ8S9YJNPAJUtnysMlHcJTbKNlGef0Ah6f2pai1hygYPReQvpsBBvcF9E5ps8qQ6WeO7Lm2N
	9aKAOJdgtYwI2E2/zesTLp9mgiGv6T0bkKqHwesCMwprezOl+oWBDmsr1axSMRfkq926tw2n4rx
	uTXr138Ikkls8tIOLu7zNb4f/M/BUZCfc7OnSjYYtJIIdovw1rE0ikhc51e4wVuoOHbQgpUnS0S
	9mkjFg3I7ebQFBe25vQc+4i66OILekT5l79y6V8
X-Received: by 2002:a17:902:e946:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d34535651emr6182815ad.1.1786483313141;
        Tue, 11 Aug 2026 14:21:53 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315f29d82sm12934165ad.20.2026.08.11.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:21:52 -0700 (PDT)
Date: Tue, 11 Aug 2026 21:21:49 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Justin Stitt <justinstitt@google.com>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
Message-ID: <anuSbSEiEfCC2MUR@google.com>
References: <0-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
 <9-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>

On 2026-07-16 02:03 PM, Jason Gunthorpe wrote:
> Add an mlx5 ConnectX selftest driver that programs VFs and PFs
> through the command interface. Create the driver skeleton with
> probe(), the command interface, HCA boot sequence, and all resource
> allocation up through ALLOC_PD + CREATE_MKEY.
> 
> The driver implements vfio_pci_driver_ops (probe/init/remove) and
> registers with the VFIO selftest framework.  It matches the same
> mlx5 ConnectX device IDs that the kernel matches.
> 
> init() brings the HCA to a running state:
>   - Command interface setup (two-slot: regular + async pages)
>   - ENABLE_HCA -> SET_ISSI -> QUERY/MANAGE_PAGES -> SET_HCA_CAP ->
>     INIT_HCA
>   - EQ creation (CMD + PAGE_REQUEST events for PF support)
>   - ALLOC_PD, CREATE_MKEY (PA-mode, covers all IOVAs)
>   - Force-loopback capability check
> 
> remove() tears down in reverse order through TEARDOWN_HCA and
> DISABLE_HCA, including async pages slot drain and FW page reclaim.
> 
> The driver region (~18MB) holds all HW-visible DMA buffers (command
> queue, mailboxes, EQ, FW pages) overlaid as a single struct on
> device->driver.region.vaddr.
> 
> Data path ops (memcpy_start/memcpy_wait) are left as stubs for the
> next patch.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: David Matlack <dmatlack@google.com>
