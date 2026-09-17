Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785E3A0E99
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659609; cv=none; b=DG8t66Rw2E3/PD2wirUiYdEbuBVs5rVxPaaljyJ4Nv3uvlvcc2l6RazX1Y/tjVXmIpQnlad3vpkeAPjHI1lT/bMOYQWkg5Staxg2hPVI5S5Dq7hURIINs1mPZ205wMz4vTbmov7geGRP/KSqxzxQ7U57meziXxqkdOZoxv6BSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659609; c=relaxed/simple;
	bh=ZEPRZWQSbrRLK6spoQmF7XlsJWpr55fNU8xc6W79Ubc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXxbKjKYh5+Ffb6V/V1YZMiTkd7GUDbYpljp/xpbbjuOwDwYpmJtFSf2LB1lhBGuUwaliNJvkg5wiy6DQo3FNe14ihslQbfj7yYw5xps3bvCnct45oWUeh411DD4GelNfOWswn2MpYtwle/aEXRvf1KtiNWpu4S62lngR3JuZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTRppooz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMahKYlr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTRppooz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMahKYlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789659598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksHKsD+rPQygiKBYrLWLevL1zmQIyZm3/sEyFnk8qqU=;
	b=OTRppoozSHKfn5LbFR1I1QZ/0vrgEj6gyYGhFpEUpvp36dj8CrSZewICgZ9wTmWIMDEgoJ
	orHkvRNsFLg+piEk07vie2H5V68c8izPpcDCHJgo127UxroVeGjEVfuBSZrVmEMTDfkf+B
	T9xDrTfGNxS1lEi6YEBoqDji73nuvFk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-DoOOeLL_NgKaWmBWq5qkYQ-1; Thu, 17 Sep 2026 11:39:56 -0400
X-MC-Unique: DoOOeLL_NgKaWmBWq5qkYQ-1
X-Mimecast-MFC-AGG-ID: DoOOeLL_NgKaWmBWq5qkYQ_1789659595
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so8395525e9.2
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789659595; x=1790264395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ksHKsD+rPQygiKBYrLWLevL1zmQIyZm3/sEyFnk8qqU=;
        b=WMahKYlr8SHBNP9db6ucA3iSYIUTZ4J4k1H0JUESmdhX8B8hYBwYp7sFxgG+Y9hW7q
         g0TFR5wwYNP3Xj8EOPljrdx662E4aFX4Wed23IKjfm1Sj59HprszncIuvdii9eILKHsp
         FIT7PlS7yI8aRvUsJt3nF5SpBG8smY1E7TvchLOazrsOZiqT+plwA2dUsx3PbpISsDY7
         ULUg998+mA38mas80VN/BUBJ8JOPDaY1+Af2whpv5BH3/5mZTQM29WOquyFqrmJZcC0s
         RvIayahvrCQBGVG8RV92Cok1EHt7KSXdZzFTC7SXfVqTpc4GDWJXtIXfpml6idvd6vS/
         ouCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659595; x=1790264395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksHKsD+rPQygiKBYrLWLevL1zmQIyZm3/sEyFnk8qqU=;
        b=JuBgnKNjBd3sGfz5gRdQufdE4hqa/PDmzgUqIMZ0aswXn4zVCGIjS4UxIA65Qpocvx
         Exj7Rzs/5Th9S/KX2u73RbDvRPlxVMMiurXkh7PUkt9E/il0pUyd0qYIWEl/WCghU5J5
         n7bqYpJsymhjKwEDv5DWYr6ug6M5y0HDCIsTfc5bsP3bl7pcgbYIv0qDTjcDLxpr0Ie6
         OMRKvdxg8Z6c3Amic9Hsmre8+4QYnb8Zjl9DcDS7jXAkAIlLED4cbre3n5D3JL5oGw47
         b/4nmuNALjotAqIhjtEQ7kHWArEiQYbdHu+DLWbsIT3euc2cXj+42r3gVECgAjG08q1F
         CMXg==
X-Forwarded-Encrypted: i=1; AKwUvBz/ZBTAX8X4DAPz+jgWaJkvTt12TQZj8dTAhR8yCVIlHZiDxN9hSBAyH2D8X3hNEOE45oY=@vger.kernel.org
X-Gm-Message-State: AFuF++kPfz7EeaDYB1NyHSvIoNwz+SBj0nD9B/g+LfYJ4uIp0BVd6I8T
	yFiJ5sU0vXlkgiXhp+qrUn1hm3fqJzWt2T6emqytJ/MYkCf+VvPpg7Xxu6A5SJ4/KgLwuP5Eba9
	g7Q1GlBaxuvbDuWXR+xZfJzcxK4BzC4jXz4Q8t2/iogWlPBP2fMg2EQ==
X-Gm-Gg: AYBFou1vRPzL1+dbx5D/a8ylyhQpcvpt7J4Qhm9HVnKZaFnxhxpCHaHKEpgnBUVqNoq
	+IO/IJeFEWlfnZr1I9bepCc0f5iFWdZLsUwpTM3ykz07VCC7zzE+SbRz96Rz++m2LPeEL+UeZ5h
	KAYAKT+pl5Zx/L4qWTnQ5+qr4Q5zEC8ta4OhxDCWiAgyS/rDuxk00zLBVdYMaEcYWitWYLVG8Mq
	FG405NdIvsaeBny8vu59pTNgRJairVGWfjmgRk65YAxvVJICJJicK/VSvGyCVuO69Y4Uo1I7zDL
	d64Okv5T2Cu2rGI80INmEKLFlvr/3oQNlX4Plmv5bqtrkDdka/8UUjHzw1S64KYjuPMbyHmeoDa
	xnuMGftTyKLOmulkJl9UTIWE=
X-Received: by 2002:a05:600c:4e86:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49eb72f3d08mr88668595e9.10.1789659595177;
        Thu, 17 Sep 2026 08:39:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4e86:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49eb72f3d08mr88668225e9.10.1789659594734;
        Thu, 17 Sep 2026 08:39:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf342a0sm16364931f8f.24.2026.09.17.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:39:53 -0700 (PDT)
Date: Thu, 17 Sep 2026 11:39:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 0/5] vhost/vsock: add support for VHOST_RESET_OWNER
 and CPR migration
Message-ID: <20260917113941-mutt-send-email-mst@kernel.org>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260730194858-mutt-send-email-mst@kernel.org>
 <f8646e25-7e81-4f19-aecc-a040caac1103@virtuozzo.com>
 <ea805767-9e3f-455a-a4d6-828063aaf2f4@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea805767-9e3f-455a-a4d6-828063aaf2f4@virtuozzo.com>

On Mon, Sep 14, 2026 at 12:09:35PM +0300, Andrey Drobyshev wrote:
> On 7/31/26 11:31 AM, Andrey Drobyshev wrote:
> > On 7/31/26 2:49 AM, Michael S. Tsirkin wrote:
> >> On Fri, Jul 24, 2026 at 02:45:37PM +0300, Andrey Drobyshev wrote:
> >>> v5 -> v6:
> >>>
> >>>   * Patch 4:
> >>>     - make sync+flush conditional by adding a bool 'sync' param to the
> >>>       chain, as suggested by Michael:
> >>>         vhost_dev_reset_owner()
> >>>           vhost_dev_cleanup()
> >>>             vhost_workers_free()
> >>>
> >>>     - reword commit message and comment;
> >>>     - drop Fixes;
> >>>
> >>>   * Patch 5:
> >>>     - add 'sync' param to vhost_dev_reset_owner() call.
> >>>
> >>> v5: https://lore.kernel.org/virtualization/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com
> >>
> >> does not apply for me is this for net next?
> >> in that case
> >>
> >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>
> > 
> > The series is based on tag v7.2-rc1.  However I think the reason it
> > doesn't apply is you already have v5 of this series queued in
> > mst/linux-next, commits ddb0918e36c4^..ad5b642c84d0, with your S-o-b.
> > 
> > So you might roll it back and take v6 instead (only commits 4 and 5
> > differ), or leave v5 in the tree, or I can send you v5->v6 difference
> > separately.  Whichever you prefer.
> 
> Friendly ping.
> 
> I noticed that these patches were queued in your linux-next tree, but
> got dropped afterwards and never made it to your last PR (used to be
> ddb0918e36c4^..ad5b642c84d0).  To be clear: the series targets your
> vhost tree, not net-next tree.  Since it applies cleanly on your current
> vhost branch - please let me know if it's ready or there's smth else
> that should be fixed.
> 
> Thanks,
> Andrey

I'll put this in next, thanks!

