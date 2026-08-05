Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E53DAAB9
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910118; cv=pass; b=o5dR5hy+t055mmEe7uwW7r3lPEqjP54eyaVv2ARdqqnWWQaDVUXon6FKo+gv/6KAFMY30cJVHCPlwPx5d+8M+FAKpjDb28iMVq5/5qEJv54quMI4k+4pjJxoNZCKWNJxEbMiebM/Qiuedw0HzfAC/FcQbBsyuU993V04RyZvBCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910118; c=relaxed/simple;
	bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7/HAtbuexYXSm37jQewVZTLoCoQzj8F5BC8a35QmmUvACPjm1t2f3CW+kohK0cOu3+aYOYu9a9mUBibYbU/wYDwRF/uvw5ATNbEcQB97/+qEKOKK9rHZU13DDz8Kt9F9/SNTi+26z0v/DAb9VxaDBQyRfQV9baW9WsfWLfrpq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZFLiu3U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+y5LgfF; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZFLiu3U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+y5LgfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785910112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
	b=hZFLiu3UwUoW2CwdY6gEUvQDxXKoHngko7VL2leRakgVyhEHNySZZVGhEE3N85C9iKFZtE
	SR9Xm6562dgTI6qF/wnLs+3EMkGa5lzbkFlQwNZPNsBXioSXpQIdxeRfedTBj5Lx0E0Qqr
	h+mFlBMv4c+GA3DKqa1wBOQ5iaFmzb8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-nBEjX4WaPCq5vYKkeBsYPw-1; Wed, 05 Aug 2026 02:08:31 -0400
X-MC-Unique: nBEjX4WaPCq5vYKkeBsYPw-1
X-Mimecast-MFC-AGG-ID: nBEjX4WaPCq5vYKkeBsYPw_1785910110
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-475e540a0ffso309532f8f.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 23:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785910110; cv=none;
        d=google.com; s=arc-20260327;
        b=nA+QvWK6FFIMzjGrIfGelA4C+fwCevJlNgjI5jxPxdyZf5KZY3VXMJ2dCn4+HBbmBo
         DHfnX9J0+SabqAW5AGylRoRrPQ0RxZQ7N+HpHu+aEw9ibRcWXdmh7C4rZMJ33LGTiREl
         OMv49l3GXOAA4QgTTOBxOP5qRJvcMRSYZu2RCQCtdLMoz5QY8sgoOO7lgjabsNyM3H3q
         bTfpKMpqdJabh8/UPof8jYYxBSv31Nt0ypMyb16wx8aXaxB4DFGPWyiA9T1V4aRVvJJJ
         Ejh1TOqPJtwSSFqdIopIZZqTM8CNZkrkoA/yzNWzYdMjMg+dGzlteVeJ6D2zEf4Nupkz
         xf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
        fh=wQle5coEvhKm6CQdJF4igNuSditm7qhAHI3Uknfd/ko=;
        b=DSiSW4IvUfrcJ5SnIEU7oV9/GpDsXqRHzp63pxNfo/UNDZDMddnqi4GjHYkmeeJa7a
         MGFfhbzf9xeEPb2b5zbXXR0P7gDTSlosOsxf19Pbr01W/A7M042J5VOR4UWUwTAtegeM
         VL09tTtIo++2/ZtpezkNu8Dtk+jitQcO+7iIdiWB2JcfwH2u6aY7HG/KC4lPwzXpqgs0
         RF5FAEd5Is2hgY2ZS16gF9XUv6fRBuDry80Y6Rb3hCEMdEO3oBsUrj7twUxAiUEDuxvj
         qU/Ujuhe+/sT6rMszr/7lxndcxivVkKhbSTM3p0cYBgmIThpCb2vbW5ED2CV2+zAzEBk
         cPqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785910110; x=1786514910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
        b=i+y5LgfFY/jp9p2qY1DrA/Aq5Jgf2ReSbS7NdouwIkk8bNPUozzCpHECiXVSuaVsIU
         A9zKCMSZnzsvYsYCIing134gae5QMiD/89iX1i91Lyn3wT7WUBE4SOx/UkpGRLHzFlg0
         aSHMiH95oOmJonCtFxg+j0u8aiAGUHrZlXfyNpHfbJh2BBnUPy8UCmjVZ2ZsP+1mmvF+
         xDotYXJiCaF8bFgjP2pmM8wER8RFrR+abo76NpO39d7lwMT5RqtJ4f4Ppu83VNII9krf
         xQdunnII9lWsEydnDOS30fuvQk4txoU5zwr+nbwIoJxFmInpBatGIiOw9e7QVSnAVBE6
         YOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785910110; x=1786514910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
        b=bKxotni8dT74zcB0oQhGj2i+cfwoWRd4cBuonCZSvxToSrYGu5S0N0xR+hSjGj5Q9c
         lu0qn5vSid356hd4qyd4X9kHoOoGIOm6MESNvMuE0kpWs4E5d/MnGJEJJ12ewpq+Chp5
         3u3/5j6fqERvzIincrMADzM6EhNxlG9hX7gATrnqWVC0GitXlH68Gw3H/avWIhNOt2wZ
         6SM7XXAfMSFTCiFYxXMClSikzxWc9NHjHhx0CzKXiJo0KF5PvS5kKU4Togw+lVBYP9oc
         5ghaiF5nHgEdSdr6ucCfXJi+BtMg31fzbxqYbOXRDtQSO45/cH6NFWaXFD/AAUmD6mrM
         QsEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+lPlDIuxdc6cIUDI0KcqwA/OPlXTfBT2LMGGKTdGtsms4kqxbLuefvaiGERF/enGFTRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE6EHkzs1bkveJN+47Ln9NlOLg4M0WrUmtoFsA64UeRAfh47i3
	qsnjeRRfR9UHh+3UJ7MiJN7uy+UNN+yO3Qw+S8zm3AtkrANoHAl4MunUSkQRDz1v4hwlo36n4lm
	PMi4kKB2I1qiQ03LxxybfyEPya14iSNDPdwuC4kq/hBDoFwetUksZ3sRtntzSQZxQKTpUuwOVn8
	Cz3QC7RRK4Ryq4awamuBVetpLFWGo9
X-Gm-Gg: AR+sD11o9wKZxIh1QqxPzd79vd0EayLt/5Yqr1dNvg63WPG8lb9k90wMnSQe+yfO1hZ
	y9YQAO+mlTu+YDta9bHEfH0fpVy8g1L0won0WgnvmWALZQTCP1HxPfCDqpo6gsjayvhisVycpt2
	IFL2Ua1JSu/8t35V2FUBMCKw4MQlBSuaSnwMDt2W51elgQk+vFyThnwLVVyTbsIRvvY/tSd9Y42
	b4Y54xCcVzkA2FX1FEQVmrFbeQ+H34xqiw16dRNrU1G7Sr5sgaVECUa9YY=
X-Received: by 2002:adf:e012:0:20b0:47f:753c:5393 with SMTP id ffacd0b85a97d-47fec4e888cmr5402600f8f.6.1785910109911;
        Tue, 04 Aug 2026 23:08:29 -0700 (PDT)
X-Received: by 2002:adf:e012:0:20b0:47f:753c:5393 with SMTP id
 ffacd0b85a97d-47fec4e888cmr5402532f8f.6.1785910109519; Tue, 04 Aug 2026
 23:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-3-pbonzini@redhat.com>
 <20260804161549.4cd9a66f@fedora-21.home> <20260804161850.58c55c6e@fedora-21.home>
 <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com> <20260804164206.655874ce@fedora-21.home>
In-Reply-To: <20260804164206.655874ce@fedora-21.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 5 Aug 2026 08:08:17 +0200
X-Gm-Features: AUfX_mzo9t9ubVXz5xpYzVx4R9t4U8bdls__QKfQW65v6eCkMtC4FUkJ5hgXDI8
Message-ID: <CABgObfY67mdG9QZ5__Q9GDrEq9Wutc42_tHo8YGSMOPnruZmsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Christian Koenig <christian.koenig@amd.com>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:42=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> Okay, I thought I'd ask to be sure, because of all the implementations
> of pfn_mkwrite listed here [1], only drm_gem_shmem_helper.c and
> kernel/events/core.c do that.

Also the vmwgfx one in patch 3; and for the !DAX case ext4 and XFS too
(e.g. xfs_filemap_pfn_mkwrite gets to iomap_page_mkwrite, not to
filemap_fault).

> The rest have their "generic" fault
> handler (by generic I mean a fault handler helper that covers all the
> order/WRITE_FLAG combinations) called from pfn_mkwrite(), and return a
> non-zero vm_fault_t.

I see; I think you can do that, it is handled at
https://elixir.bootlin.com/linux/v7.2-rc5/source/mm/memory.c#L2681 and
indeed it returns VM_FAULT_NOPAGE. But it's more or work for no real
reason. Your .pfn_mkwrite is a single line of code and it is clearer
IMO if you can see that try_insert_pfn() is calling the same helper as
.pfn_mkwrite().

Paolo

