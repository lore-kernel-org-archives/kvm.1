Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF143FD11
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854083; cv=pass; b=M0KrD/15RCVYtUXd/5GH1Pc4KHlbvbIk/NgkvjRFepJ+qfDY6z7ar8I54cYMWPYlpoy3GI0G2agJjs2KRkJqQ9uWkNMAg/fNtV50QEhJUwxeupAYmZ0HUpa9Vgzk++chb8WFLi8Q8WBrbqCwBh2fg3rs69vJJN7OX9LIoz+Jdmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854083; c=relaxed/simple;
	bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAcoF0DIMT5qZqnNOxYPXsVOQrIPKNVSZ8J4u2xvhj/56JLSjgvGoArIQnmY2oVmeCEHMq03tUVFb61KMUSCCYNg8QR6ti8UGKDbxMZXQfS++szy72sJZZaybUTOfJ+SrtfCNFNd0lGdJUmPqcS3iP4BOvhC0gRduOk44lVlEWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3we5V7U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oeMRMRpR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3we5V7U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oeMRMRpR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785854068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
	b=b3we5V7UvlhlD3TTG9R1sBM9eROLbjYrnKuw+fq/CN5lpvoGXBS33Rxag6DJstwW1aMFc9
	m1kzFk5iFziFyYifY28KKX1MqdZuKKpTMDfSjw+PFRVLR+QcOl0rV2tnvltblqIG7iUQyl
	IP9zYpw8Ztil/RJ2qInZyjdAgGV7MGQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-g5Uql6a_Pza7P9yP4JTL0A-1; Tue, 04 Aug 2026 10:34:26 -0400
X-MC-Unique: g5Uql6a_Pza7P9yP4JTL0A-1
X-Mimecast-MFC-AGG-ID: g5Uql6a_Pza7P9yP4JTL0A_1785854065
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso25102125e9.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 07:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854065; cv=none;
        d=google.com; s=arc-20260327;
        b=dP8j2d/vUAKoCq1VzZNGTUXdQOFhAOq9PmoDWqTkz9b06PgtQSt9DMBvQI0zxFG7XG
         q8eZHQLvONsgwUeYXRwNRenkFCUNY/5bp3dG7xE6do1fy+Nh5qfCMkt5cNWlK0kTtclC
         OhtKSS4Mqs9nB3adQoSL6h0w2uiBMnzZzWQaW0CxZ3AJNhKLX/vouADldUaKrINm90Kp
         PToOZvB8xOkf9qYXo9fus7GZDGOL2v9gbu8gCd2QE8na0MCJUy1CF2DynxZIWs04xYU9
         wVzwXu0RLZA13GVq4ZswxWvSDW9WYmEMzmWgf7ICDuDUAQOvEjDmp+b3WFm195WC5oXs
         vKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
        fh=5jmCQYsAOcAN4U8uVvsjYVg7ncxMVBEeeJd/rxz7olk=;
        b=b3jEz12az3ViPT0iNqwnhUW6btZhTyg9u1gBlhvEV2fO3SMe2whi3ngBMWYhHf3nDK
         H1ITqoQrIEFKBLvQt/Xy/CRxxydRjp9Yk+zgBgzH9xNzYMmwFYbrSzjwWDfkZLOWcqWs
         Y1MKw8PtoaaSJpxFD1xYDdFla9l9lGhKVmsiqNs5yoPUMJA5CgZcU5o9RvAdonKr2Cud
         5yHOo5KJNXiCescBPxNWPp6eq9O7GaRjYienWJ8eaBvNCeSPTpWxwafK104MHjcdcAme
         c5JmLKA9F8HNCmNX2j772+YVYVJy1cG1ArmhG4ho/H6K2CHhpYTB0OrhyYNzeMsP/J0H
         Io9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785854065; x=1786458865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
        b=oeMRMRpRXphJnO2A7FxxFVB0wCiMjMW8eGzqDqv2/23j2YgrmWgB31vK8yab9wfqmT
         jeXV01qn72sI+XW26nr9Pp+VaUaYtCIwGOEN2kQTbP3Y5NDiF11zSq+99UbaZkOJkRn+
         lP98cWMUkl/z3pBC62N3IYiwBs9uXTzp6ONVbnk7Wy/UqTkWYoDzNuetR4hI57Tb7Gb3
         /7h/ywWBQEAF39kFKL65t05fzKpIOE81lYviqwnR+q/7opfdn1AhQ2bxyR0eP2Wrozuo
         8Dad5ojqaEsh4lUNarBzp+AdKK+TZjHygsQvdW9wwyZz9AEkOYm7Q+BmyYiQYiS4PNGE
         T9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785854065; x=1786458865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
        b=BkYSLYpu4/9Pu2310eBmGCqPG6+uS2SJcxGmuMhwUfb/XzIBewHS6rGdK8f8Vt+3Xh
         Vt1OdWwZwzkwRHCXegVTFRlYbRVKlfmUOMtF54EZ8gBebxrgwblDbyUn8KeTez6MkIWg
         qQqdmEK8Wzltr0Vd7JRvnORKIJuZs8wHeF5w6DYkyEpy8ZEwzeOrHmi5QccVaBHQJUh8
         chJ+qU1nHAKB/yRgpooEcB8kwHTB6w/f9HdhCWyPndhLI7J5yH21IhuPT7movRSY9Ia9
         RImgNYEQNsxhOKA6B9atrxyFCWOezRYSzWiIntJf1lzN/MzDsOlEWidcz15sAWog6MMG
         ZVZA==
X-Forwarded-Encrypted: i=1; AHgh+RrPQdgdSV/aSO4fP7qNLuc8VKGBMH0h0BdqjRbeZQsLW9xBiv+KvIXQV9EVnNc0f4BBnEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUL+aESFocWBwiIaPyazOJWHm6sGzKfS1WUEeSBn+4QtQl3Tzl
	+TN+5QiAenVXBCAbX2FrxiPTo+tL9XDichIK7b9QF4qDmrCCTsYJmHyTvkaXNDSS0uPjNZHWpZH
	8nPzBEgaQSCggEIbYkXkql+BFE2CoUDosShGmG5IbsRrU7NGR0Hw+nOwPrfpZ6qO4iFMTzjZ7z1
	B1tqB9WgwdC8Rlm8VqmmtVDCvla7h0
X-Gm-Gg: AR+sD13dXWxa0EM65xUlD9Gdjxcazh7dVq11ZOaifD+HIEu3VQLEf6hzaTKY8TKEPdv
	V2JINq2dPTriFn4DEoBEq3b7Jw3SvlQ/D9T2srLEEmegf1mNNjwmOhjZVxHlFNVscDeTha4K11t
	XpYjg9PvQ1X3XKnDQRvq6RppIh0h1P2GIrS37Cq53TB67b25oAb6Q8+NaycOidZnvD7hYBWeuCs
	wI66V8K8Qd3PZaPZX/iLbRtcij+LG5mCcJoprJw8zldlucpKLWZBpfX3ww=
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4980f23257cmr337369155e9.11.1785854064975;
        Tue, 04 Aug 2026 07:34:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4980f23257cmr337368035e9.11.1785854064514; Tue, 04 Aug 2026
 07:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-3-pbonzini@redhat.com>
 <20260804161549.4cd9a66f@fedora-21.home> <20260804161850.58c55c6e@fedora-21.home>
In-Reply-To: <20260804161850.58c55c6e@fedora-21.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 16:34:10 +0200
X-Gm-Features: AUfX_my1qzxj9_dJklyDF5G5un-IXavjOuTxcyczoqFAniCfVGichGNEROtCVP4
Message-ID: <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
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

On Tue, Aug 4, 2026 at 4:19=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Tue, 4 Aug 2026 16:15:49 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > Actually, if we're making the drm_gem_shmem_record_mkwrite() call
> > unconditional (for PTE and PMD updates) in that path, can't we drop the
> > drm_gem_shmem_pfn_mkwrite() call living in drm_gem_shmem_pfn_mkwrite()?
> >
> > Also, I'm not even sure we can end up with write=3Dtrue for PTE updates=
,
> > because our pfn_mkwrite implementation returns zero, not VM_FAULT_ERROR
> > or VM_FAULT_NOPAGE. This means the default RO -> RW PTE upgrade
> > implemented in finish_mkwrite_fault() [1] will take place. If we really
> > want out try_insert_pfn() to be called for those RO -> RW updgrades, we
> > need to call try_insert_pfn() from drm_gem_shmem_pfn_mkwrite().
>
> Nevermind, it's all explained in the comment you've added. Sorry for
> the noise. I keep wondering if we shouldn't call try_insert_pfn() from
> pfn_mkwrite() though, like is done in other places.

No, the .pfn_mkwrite() callback is invoked when a PTE already exists,
and mm/ already takes care of making it writable. So there's nothing
to insert, you just have to take note which you do with
drm_gem_shmem_record_mkwrite().

Paolo

