Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556004;
	b=2wcRRoUnvncJnCF1wfmDvk1EBdvZp7gSdRBSgyNktYTtsJR52iVOWngQIApInLl2oZw8
	 z0+ByHmee/JSasgcuW/+1ymXVh8VbZ/rFFYuNAgDt4MA449kTaKzeVdRU1fQROcTzhfRS
	 P/aWbKPDFubo2AcjfFt5dPBAGwDS/r8VXGr+avZBxD1ZI6B9j9TY9nWuWnz11yVl8R4dX
	 IkQPfo/7j2VdP6HjwmyKPm1XFHFqCLuwOKE87coFS7xErKzyiavkuO8EF8ns/1SnZfGOL
	 GRak791r2dS0TPB81W2vLK6NRaCMQ/Z0QRtMy+piboMGqiVSKcWp1D1F3nEkKvD0Sfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=a43i/wMJK2Jdp5fkamBiNm3l8yCGMzExiyPn/eHOlLc=;
	b=W9Xsf+gCK+eBQFl7CwDj9iJECx8y+nbIIy4igDk00bt7R0ZnGWmrFpSXSoewXk5tTfV/
	 PfYS/6RYdfMZpFZYzXPxUJLGx9citcLh54WMyvSH1/JI9Qwl2hzH2n4042nrWrS8/cdlh
	 JjOIcLxsfvbJgMH8gfZcM8S7SgTvM0dFVD22UKwjsXlJWrC86uCcXgDWodLMDBbEcsvf9
	 64SmKGTvsqp1TGWsOgntmzEj/8jJ/mOGJtU/2b4Bsj6+MV88NyHa6HHDc3vsyM9kKZMm3
	 81s9pCKyP9RU5njnt/L2CoaSsW0PCOt1goBquvHa2YTKHXW2xnM3U0x1uFzSfIzjFZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ekCNuwIq;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783D606A330
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 07:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C783D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ekCNuwIq
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a215e64962so10442735e9.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 23:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1794556002; x=1795160802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a43i/wMJK2Jdp5fkamBiNm3l8yCGMzExiyPn/eHOlLc=;
        b=ekCNuwIqvKNyzzP8/TogupqdJ9S/lTcS7kvV5Lnc07oznazi/+/AbvzHMeKj4Fz1k/
         WV5ADfsksKzz4ELlKIoFlS6TA7id5kKKUA1hVO+Yp9EZyWmGGu+BUQFTzuxXZDkeYW3t
         0/c5MtBBPMOrTOMC+n1elC3PUHPP8C/w6FZ9ElwI44//poPXrTAXH7iCb2gcW+4t6eU4
         xrIdqrcrQ8pdck3vGfk+UCq75Xe2ecgvgCv7bVAKOOuxg/BA7Y6lm/pkjla11OXMHIfe
         SaWd3WdM6Rjr5btfGjNmhZl333D5rooop+oX4EYmKyMJ4vdawxFBQ6gq7z7QHEWaOa20
         e3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794556002; x=1795160802;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a43i/wMJK2Jdp5fkamBiNm3l8yCGMzExiyPn/eHOlLc=;
        b=y7GAtLTwTEe1ht8EJmy7FvBKHhgypyu/cjYTOjT8HFgg31gGSkQfapZz9d7jusV4bE
         nuD1OsL0LY2ayNAQamhHANQPunxzHgNJg2Ku0qoJ8+VUr/qD2VzX7FqoikGoaNfvMgDb
         Imi1OdbkUj0hGnOJoDFMh3999CKsjPIqzZATmawFR4rcV2hg6QlIVwHJUmURmSJ4vOxi
         udSDZIEFM8tFG0ebvUr/seyB9DJLKjRi0qadTM8vFAEzLwf5B6KL0VMhY3o7iborSUby
         2d3DS6NxlAheaTFQraNoJsGaGzWaYKcDFh4SBMYqZ8uotUXde1F1slHFK8tURtXywPv9
         R0sw==
X-Forwarded-Encrypted: i=1; AL+hErEWFhyvolwKbUgUOPjg96fVX5Rbf2lICdLJQQ3il+0C/hEyaL47MsKwIkqfaBoaqxwOiaI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+16zjndJ0URXrLEf9LEtDTalsF7dExqnPXW2pNu8j0Eb9LBivf
	U4xYRcGWFqzghtsdt5u5ZFBDf6s46TLxERqs/Jr2o9okkHk8Ug20TWn9jHTo9bZVZDQ=
X-Gm-Gg: AYBFou13X53cosws8Du2ABQq6U2muDRNxfZFqFRQQb79S9sT4wRaLgeIM8BnePnEvzl
	u3rDqvGafkiJjnz9dwIxzWO/6s64nIdO08iHINXyfi6Bq/a1tEnX4AoDpkEobe2EnuworpCO9xs
	rnkzYWoEokBhin02Ol+AfmddJfNcIzfQyHliv6Ze76tqNXYjSxeBRrsyv939bFEPGksyXqU8jSU
	HJ2AMEVki6eWWPsO+ImEtPHXi3a+eDdNJQvickl7VHbJs+RGndVj7LikmT2J4e8GnxF/MJ0EwgN
	enHmWk0rqLe54t4ZVbiM17SHFl8vdNTzw556oJ5BKmd+Z8GVG1P1QbWnZ/guiqQKc9qddIJjCnA
	TVPFHua/9psiJI5/EXF5GAVlEebKLiOM9rUQ/ACclg5FPI33V2zjwgn7OroyM/9Cw3hBcRhu8tW
	a9fCcq6ma0IGESwuxY0b84ROOWF+Nqig6FX1oO2N4rHmmB7XPcfG+sKAfBPg/wWwGvgmRDs143o
	4LhVqTckxLLkoY+QR/L2Y/b5UGeUUuqsg7ClXG4QMrjF1BA8eYUEtKNap6rpShbc50cAmAtGVPi
	6yxNuxq/JxDQ/+vdwNQ=
X-Received: by 2002:a05:600c:1913:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4bb55ab021bmr34881985e9.30.1794556001990;
        Thu, 12 Nov 2026 23:46:41 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c8d286480sm5348297f8f.7.2026.11.12.23.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:46:41 -0800 (PST)
Date: Fri, 13 Nov 2026 10:46:38 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Priyanka Mani <priyankamani2100@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] KVM: nSVM: Check full nested state size before
 writing to user buffer
Message-ID: <avbAXlFsL4J4zPr7@stanley.mountain>
References: <75b8ccd5e278ce8f13bedeceb196f5b4ee9c5256.1794545500.git.priyankamani2100@gmail.com>
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
In-Reply-To: <75b8ccd5e278ce8f13bedeceb196f5b4ee9c5256.1794545500.git.priyankamani2100@gmail.com>

On Fri, Nov 13, 2026 at 05:01:14AM +0000, Priyanka Mani wrote:
> svm_get_nested_state() compares the userspace-provided buffer size against
> kvm_state.size before adding KVM_STATE_NESTED_SVM_VMCB_SIZE for a vCPU that
> is in guest mode.  When L2 is active and userspace passes a size that is
> large enough for the header but too small for the vmcb12 payload, KVM thus
> skips the early exit, copies out the header, clears and fills the full 4KiB
> vmcb12 area past the end of the buffer described by userspace, and only
> then does the caller notice that the returned size is larger than the
> provided one and fail with -E2BIG.
> 
> As a result, KVM writes up to 4KiB beyond the buffer userspace said it
> has, and if that memory isn't mapped, the ioctl fails with -EFAULT instead
> of the documented -E2BIG without reporting the required size.
> 
> Move the size check to immediately before the first copy_to_user(), after
> the header, including kvm_state.size, has been fully filled in, so that a
> too-small buffer is rejected without writing anything to it, and so that
> any future additions to the size are automatically covered by the check.
> 
> Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
> Cc: stable@vger.kernel.org
> Suggested-by: Dan Carpenter <dan@pereq.eu>

Really suggested-by is only meant for original suggestions, not review
feedback.  But I'm always willing to accept undeserved credit.

Reviewed-by: Dan Carpenter <dan@pereq.eu>

regards,
dan carpenter

