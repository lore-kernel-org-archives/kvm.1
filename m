Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA53C5DBA
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816204; cv=none; b=jIHx+QieFozGki6sPEvA1N2eIU2jP4D+KfeXlGlPp/9N/7FZdmQGrA80JRT/UW2CaeLq5cKGv0ShhrpWAsuR6PQT8pOnxpSOibMTgAkGRId0GuJ3rdlmroM8au1kH8uqQAXVKG+RAffEW82l1npIOk4bQUI+UAtx27xldv73QxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816204; c=relaxed/simple;
	bh=Gzcz3Zkq6mIgF9nN+/RZpdn2G6QVcg2SErOL9iM3Lwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/cTtrO03d/LeH8Hx1Ums9GxXjKlsQDKvuhQHFLUm17YH8Z7nOuKUE9UGcc+wjjZCVSKqofKje1NjuSNn63yTTGZLonleZrMPHHjtYjcjC+p+IuuIfBAdzGkSVKtNCGUAF8RY1Q00ct1bswdmW1CJopSyowHsQ7MfEldc+1PLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB90dpFH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB90dpFH"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so2139037f8f.2
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788816201; x=1789421001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zj4alWZ0+Z5ViHZ+ZCYKHStoDMFk30/0JNVi4/sJSpo=;
        b=dB90dpFHKckqTrmJjkDD5EUcDaUVt1xE4+JqKWmDR3ffIvrgUgRi0TAZJOpGZIijr3
         r/gJhz7hTnDw0qeQtUWHPCJyMvEL5GJYheAVws5eMPQ+/xr0LhAuuMOsXifE3Ev3aN7p
         yr25BWL5Y0XVgpuO5hLdUZU7udToKuVTxl0DxeCYuTOPpeqADHaqXa4AOQLR1GKxqPPE
         mIaJEwlUqTmTEvBkpxsc/uOL8JUdoFiMsBzIKmjG2zLo2S04A396WnRs+D19swYmLDHr
         s9E/nQut36rJRvxtRVcaoXwRTSnjMNWeIQYjAE5zGTXq2mGfq/awfBiz04y+azvUSlL3
         Siag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816201; x=1789421001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj4alWZ0+Z5ViHZ+ZCYKHStoDMFk30/0JNVi4/sJSpo=;
        b=pGgTY+ZXe71ahshwzzojnNYcu0ntTDT4KHcLe+LGEbABaG9wWUX4ci1WOMEfhqMr2h
         5mVRrIOJ7nteb5oPOMxiHzXpJf4Iz4fPrmrRi17fPCRcLEe7O2mF5++R7qTF+xpyn9aD
         wjo8A86NWBGfZ0z9/vVuekZjOkHB2I7NfnnQfFFLQDu9t0Z0daIky38p/PchJnTeyAmN
         ulCuo3WTATCshWBbKX/Qe2cSGD3lKhq9/40/gjh5Gi2rtfD2lRybCh/j92V12fx0CZex
         ydoCzQe+oFCGrTHRei+hm7770H2GzCGUjCgqgSfWQGy2OUzQHjm06zVPnVRys9qnfkcF
         Da/A==
X-Forwarded-Encrypted: i=1; AKwUvBx0qrs2rFUXD2Rjfi5oAR5LyQvHWfknRAsGRF/7fAU9SkcVFGjXGVY1uULL5N4ngBWWhFU=@vger.kernel.org
X-Gm-Message-State: AFuF++kEOydonHsiChOylLsrx4Rtt13m7wFURdJA+f8XRsf9UjR3Q5M4
	YTKB8Mky04TfcNP8Vc9dgxMWNj8+Agbfit24iWFH+76sf1Wo/W+B00jh
X-Gm-Gg: AYBFou0nkueM1JDftAx4TxL3YH0/SxfAs8IKqaxO758Lp8VMZTFd3romEOaKRJ/2dZM
	K5NghtxHt4/Lv+fzNKxNpGkSz14up3hZUFzQy1nCJpTVv5tZEDRPcW0zLE7Jpu/5FC/HLMNm8+R
	WPLK6rb2vNO8KUKBNFpfNXs52OXqZBrULU/4QM2EIVXQm9gb1ke2xkI3u06XLPqww9MX5sQN0d/
	V++0ZhBssCaJxWWNsYYwNMBw343B9FXXIDYOv+eI5R75SOfg2Dttl5+Hx76vXQxiLhhKpLGXJJ0
	KnCe/JfeSzkMO2BxRShJ/cBjzOvAHZBMwSXZkoJugxxkJoMyhImXLKTe6vYize2p24ja1MKm7Lq
	G/fk+OHGRt4p4C9Cxzd4+mMoEkuBhI7SL9pMfK843OIQEK6JDCfVo3cqqs5SIsCyCszIQbbW7hg
	SOW1DNIauBXuONilEBW74HIRa8qcphh350uahJ5x1TZUAaicDWrhIaiZ6IM2e442bF8QRg3Wo7w
	VBmqWOsvn2sBxDj5c/oGAY5GgYBJx51Mj62wk67VVXN9LrKYTaD4NgJapcdFSdp+dtK/6Xafj1K
	1HIjOdvG/LHauvcHr05TLqC4f1jWudbpNLXPMCPWO6B9MHm96oxiHssxb6THbaHUBz3BjGrn9Nb
	opLPBRWY3E4A=
X-Received: by 2002:a05:6000:4a0a:b0:484:3310:f39b with SMTP id ffacd0b85a97d-485872e05f9mr26354952f8f.28.1788816201067;
        Mon, 07 Sep 2026 14:23:21 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ac2b4cdsm29964718f8f.16.2026.09.07.14.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:23:20 -0700 (PDT)
Date: Mon, 7 Sep 2026 23:23:19 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-input@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <ap8rCQII9fASEosZ@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260907091033-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907091033-mutt-send-email-mst@kernel.org>

On Mon, Sep 07, 2026 at 09:13:28AM +0100, Michael S. Tsirkin wrote:
> got all 3 patches now. it's a good start, thanks, but they need
> a bit more work, in particular addressing sashiko comments.
> I'd also prefer patch 1 to be split: moving code from pci to core
> is separate from ccw fixes.
> 
> Pls write or at least edit commit log messages yourself,
> after reviewing Documentation/process/coding-assistants.rst
> 

Thank you for the review and feedback. I'll work on a v2 now.

Karl
