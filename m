Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5A3AB5B2
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882036; cv=none; b=XWucyTkP2M5u1swrRxqRIDqfNuKCSDFg23Wi2cnZnB8ZdO863KPK3tyAxbI337SaF9gdS12yhq8mYUR6m2k1p7NckjjpwikCFAz57qwAsGGyziVWqPLSN3bY/oeknKsK9X6vWraJl3X/gYhs7TLpQJ/At9hDr1ocq/2qq4JN2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882036; c=relaxed/simple;
	bh=xxsJ4vMVHmpRdBWcKomsgeDzkLgmgI/VbRk3+fLPUew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz2QrX/ShwfzwIZsgn6ADskAACu0hJt0EGFtfhYS4WPD6X0Bn/GpPTOAgtB/i5NxtaZFlkkGkUAWvmeAZ8+AAwygMJja1RCfohNRygwnKqLLDhab7dzgLIF8xm5llEd2iveVyw5Kb8/sTywqUUxaBx+HJ/f6TuJC4YPiJPxAhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eucRzzTl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k380h5mF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eucRzzTl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k380h5mF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781882034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY9zXhKzVITuA8MGsWDx4DYJSZbSzt5qLXb4eP7myuY=;
	b=eucRzzTlWOFG/C+0mOnNjTeeKYK/Ad+HaldJ3obqIBoqQ/FvPXFCLO7SrDrixkrKcwVBAP
	6+uYA9XWIIZxWPIakF8wfRe8Iaq0Yds5GQOWlOURgsov+f2taqCd7xmcIG5hm6ohzbiJ1z
	vmpN6VXSvEsJGFiNQob5GXjwxAM83cc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-0RJQuXwzOwuxEImwWnFKPA-1; Fri, 19 Jun 2026 11:13:52 -0400
X-MC-Unique: 0RJQuXwzOwuxEImwWnFKPA-1
X-Mimecast-MFC-AGG-ID: 0RJQuXwzOwuxEImwWnFKPA_1781882032
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8cce230de8bso66997936d6.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781882032; x=1782486832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WY9zXhKzVITuA8MGsWDx4DYJSZbSzt5qLXb4eP7myuY=;
        b=k380h5mFVdV8awcrYan9FW9EJi5atpbeR/5mST1c+KNwzmXCqYTiD8+edcWoFQDENk
         hksENMf40tYWkO8tTX/cAYz9zoX+aKk3Sn1NfjUMTRw3OSve3zB7gzgD8UstS4kPxKfe
         KeXgCCtlOMVPnRQPClP4u6RyO5sw/Mhp9roSNv3Af9acK+wXf4Rv4nVrEE/5WfUrB8cj
         foGIy/a7F1UhJ1BDfiaaIJ6EM6FdEHzbe5fvYOz6bpfGTeY7sKcKcoF8cYYs+VAM11q8
         iwljlvNwXa1wMnU7f+yP7XN+1o3v65wGkPZQK2lyFNXivgglvWLp0PLOioiw3oKQ2N0v
         VUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882032; x=1782486832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WY9zXhKzVITuA8MGsWDx4DYJSZbSzt5qLXb4eP7myuY=;
        b=fYGOcwIYaJEBH6acbzIE9as4Un1fr/XtmBKc7BDI6GTuSk2+fACaU6u1t/7eLAxeLl
         ZTYv6fXECsDmfm8qozEGPLcn50YSC6EoPlW8wshL9E/jAYe1fOD9adswLCptEQNQ1DRP
         lHthiVvhKPuqKVIbOf+MMkyySkuH3ZBps9Jr8+q3BV+kljEYjzfwIgIErdf9YNnesonS
         0fN4YnRsAYxmnrU1EgaI2oKZFl2sqkkjPgE9wB4xrJ+LW9bHmEIMdFmOYOe2t9n43o/n
         d+0zMiw+QIn2HioMn4lWmLXsxU2GTzP98MEGvqYXGA2YGB7vUqKcJ18FYTrn4VRyybSP
         AsWw==
X-Forwarded-Encrypted: i=1; AFNElJ+kFt1Ov2VS3KD3v3fMEN4AuGGzCD4GDn6QTSH2GGxPuMeEayGEbrSkSJtVTo9yQSSVJ58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27t1160/ZcUp+kqNt9mIkYJTa/ZQklwNmzacPFkJ9dY1ztG0W
	EuBQOZO0ezAxs30PBEaev7NzVbdbAyHSG3UZqEFvfv7ByGil5twoZgT8RB+fuq+rlSRz3y3FRaN
	y7fKVW9pfaCoQuMnGw5GDXyRxCdRJfDaPB8vFJ45jp/8fv1jOClm6zQ==
X-Gm-Gg: AfdE7cnAE+ZA4FZhlSC9iOnSXluX2lGwHxDs7jE+IT0HLsl/PF759dOvoU91UtrIbwp
	sZdy4WV2K4CeqzRvO+RTSYnx3GAwOu16bGjbxi2V+eVljoBjgltfp59xINeh40dZG81oCVy+sRw
	kUhBbVRbPAsYctu/mdhMkAhVLes5x/2ItmYumiGTf14vfl5hHrsNrM8DZdhKs96a2uB/kJYoAjX
	E5bzQ5mDaIJxFKwhc/8oZCVcVbHIRm6j+7JfbJ5aa+dCqeNW52KMmIo71S1AcGXqNAtR7C+wvW+
	8y7g+FYseRI0qH37wfRUws0FJCyASN8nMDQAsliZ3ZftRTWbKwlWdKL5lcNAOsY0Xac1WUnRwX7
	KRHjO
X-Received: by 2002:a05:622a:4c0a:b0:517:6afc:b644 with SMTP id d75a77b69052e-519e4db674amr55150271cf.47.1781882031954;
        Fri, 19 Jun 2026 08:13:51 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:517:6afc:b644 with SMTP id d75a77b69052e-519e4db674amr55149761cf.47.1781882031416;
        Fri, 19 Jun 2026 08:13:51 -0700 (PDT)
Received: from x1.local ([174.91.117.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-519e60ede74sm22190141cf.25.2026.06.19.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:13:50 -0700 (PDT)
Date: Fri, 19 Jun 2026 11:13:39 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
	Ben Chaney <bchaney@akamai.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
Message-ID: <ajVco512NDPKDPTr@x1.local>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>

On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jun 4, 2026 at 5:46 PM Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi,
> >
> > This is an attempt to fix the incompatibility of virtio-mem with confidential
> > VMs. The solution implements what was discussed earlier with D. Hildenbrand:
> > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
> >
> > The first patches are misc cleanups. Then some code refactoring to have split a
> > manager/source. And finally, the manager learns to deal with multiple sources.
> >
> > This has been tested together with the Linux kernel series from
> > Zhenzhong Duan [1] for TDX guests.
> >
> > (help fix https://issues.redhat.com/browse/RHEL-131968)
> 
> Can the patch 1-11 be queued or are we missing something?
> (RFC patch 12 can be dropped for now)

Likely yes.. one thing to double check with you before I do: We don't need
the kernel series, do we?  Since when unplug, I expect with the truncation
approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE then
unaccept is done (?).

Say, what happens if we run QEMU with this series applied, but without the
kernel series?

What confused me a bit is the dependency of this series v.s. the kernel
one.  It seems to use different approaches, but then I don't understand why
this series was tested with the kernel change.

Thanks,

-- 
Peter Xu

