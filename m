Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578968;
	b=EM9WICkJRAmeGPLEp2JeEjMQ6GVATAUN5VFfly+G3kftIOhQ3zVIJ9Mk1rjIH+Hv449+
	 VJu2GK/ab0H7dX+uHutf1qj7BdNdfIeaZTBMX5dr+SBVrABvzqGDMVkJlR2EaixmAm1W/
	 Srd85rt5RsxF2O0MbfN3f3R8l0eVJaOjMyJWLbfIotnV1QFnfa5HH2/7q7RJSepEq98M/
	 kzRjQZqPwZg9PnIq2BWcyJeq7TOicCMabaTCjgbN1LPIQQXpOmoiCoKx3FJeYYM5mrAZf
	 1bbzxdyGTU5i/oYpceCSdM7a2KzgBbsq6tQQr0hRWjlVodQvahEc25YB/358lKSyeYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578968;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=JOVQ4ASZFEh46dK4HlVqM/YOvdjeg+7exp1HRpI2jDQ=;
	b=qPKfXvWeSdeaEThXSLpfcgIYaS1VszBbEQhTQ7bSVkZVt/gm6Slx7iD+8wtOz+b2PjEP
	 /k8FjIhekE5A4DpIDfqms46sswqMY4gyPxki0TxF2Bth/D7WAbloygzxbIwKWLLgv7Ziz
	 o13D6mHQ5hp1gGC7cu3Phup3li/yolfb/GjMmHrAtD/eU6cz6/NmrLdsVNZlXqVQh9RrY
	 6pEC4t/aFNe0e62jNuE3CNj5gNy8YYZnXQhpOZJzfaiU6A1kwf5uLS5J9wOAJYrxxHhTZ
	 DnbXEpBY4Mq+YUZ6iAjmwRA9iM7S0B2rkoiIeJK2KZX0T7lUzNR1v01nJZfkM5SSilQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NAmYoCUe;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i3IM+YbR;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C71606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 00:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C71606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NAmYoCUe;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i3IM+YbR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793578967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOVQ4ASZFEh46dK4HlVqM/YOvdjeg+7exp1HRpI2jDQ=;
	b=NAmYoCUeHojKJL4HlPl4u3dwQ1W+d+ZevazbKbCMN1SoUHcUOZBR5RrtpTBE38zXw8UtA/
	sT9+XZRcbax1pZRV3y4eSZGfkNR04YNtDMRlnw2HfahEtUxS+bTPXKKNN90Z3uK/zEo/I+
	hOcWDR4k0ARe6/bR1B/1jlQXEKQlwlE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-lhACc4jPN9S4CRe9nJlqOw-1; Sun, 01 Nov 2026 19:22:46 -0500
X-MC-Unique: lhACc4jPN9S4CRe9nJlqOw-1
X-Mimecast-MFC-AGG-ID: lhACc4jPN9S4CRe9nJlqOw_1793578965
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso1717428f8f.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 16:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793578965; x=1794183765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JOVQ4ASZFEh46dK4HlVqM/YOvdjeg+7exp1HRpI2jDQ=;
        b=i3IM+YbRTEO2DjGr7HDtpuqLZvF1Ln88dImlEcAIGSWu8+yijEvIFl+Av8d9Jqy9II
         QnhBehQn9mrrTUbaH4x0IOZnmqVCvfN8dyWp6QCobQML0HbIYiOg7vrP6qjmoLPM8F6v
         tyVhQvQDGWbNJkaiMcUWuW/pHwzkp2pyluw06rd8kfiUJvnpANUIBZm4ltZHVXtnmWlY
         n8NKwJriKOBgeZAmVY+P5EO1bAgFaUKXrb+068Kb57qDDujJpT4SYb5T5EuA2vwW77wS
         X2jmCXjhoCubd16Q9Vt3NSKD6u3QdtQ9+J5RgWNigOsqIQ27oZRJoeIvtG73Uz/dZKdo
         Tupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578965; x=1794183765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JOVQ4ASZFEh46dK4HlVqM/YOvdjeg+7exp1HRpI2jDQ=;
        b=Fk034wPtybTeyaipnBPBEgURoQyaQUeyhqmdo2kWj3DLFySIFgT42vV6wAisAj8TBZ
         dKKDqqWhHZA12dpxiY88erwKCfrxyiHeeL1S4zPwsquC0hCbVnzlJx4qcCPmXxNn0Aru
         3iQkuGSaWwE6OK/jYoQ6y6gUNsm3qs8sJbac19nd9Y99/dH+PWyw509CEL9d9Ph5jN8T
         wIzDFcup5gABJZtB8cA84AaHz/Otf+XMsiZDTd0M+bdxWYiBxg1zgLcd1pmhGQRKvDxm
         Zgzim1QgoyKaq8pFXl1u9hQOqhs5NgpZBs74FcXEkSaO6TUewvQAGWrWVoopYrp/gNZZ
         H0DQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBe7+XXf3ALrFD037tSB2AmKMxRkrZ4hvMUPfXeStz2MKGwP8KkBliCsf6LbjK8Su10OE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIffk3XLJHGEbiZaK4nwOAPxbvhmtCC4lh+EGW8fUKvVTqahExf
	y3WErHcWWnmUrlTLO9+81qmkLIeSYV10y+3+0nmDZ9cvwvLAD89Bu1uzii1ntS8VoC1Be3glcGE
	OU6SI1LAChSpqIbB7ASN0Tn8XWF2TU4jteTf2FjJvAHvWZz1GcWhjWA==
X-Gm-Gg: AYBFou0qDBhuGUVaoV6ujcBscWPlBi+i6Eqi15+WRnatYfXk/sYy8RQoNX4ghBHSfXU
	87/4PkHbUq4RWEgy/dcqeaBJflUKCdxwpM0SoGpiyWwzBOWsrURVPOd6dUtYeFRV/hnstn216Xx
	ADSKK7rUJd2sYtLnIEUXMG/+Yv/Df6afkyQp/2C3KUSvLBKPFegcg67rpMPKU1Qnfi3hx6XySsU
	lC1Qt5vX/K3EoTw81XFsFGYS+BWdxiwyx4tlcGAdoK154/Iz69UVD/oQo6p3akNOXqIPjNg9nkV
	1Yoc/BFJY39fJty+tj/+0/hYSJlRBx+1aQojabaXYlGLblaMLsCfXThAiw2795h9OEFiEbmAsVj
	q9E4sgLqAziJPqQpq0RjDd3cXxknECzRE4BMyEh1I7g==
X-Received: by 2002:a05:600c:1f87:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4ac17b2be08mr197874425e9.26.1793578964618;
        Sun, 01 Nov 2026 16:22:44 -0800 (PST)
X-Received: by 2002:a05:600c:1f87:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4ac17b2be08mr197874195e9.26.1793578964162;
        Sun, 01 Nov 2026 16:22:44 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aa704sm220328625e9.8.2026.11.01.16.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 16:22:43 -0800 (PST)
Date: Sun, 1 Nov 2026 19:22:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Linfeng Sun <linfeng.sun.dev@gmail.com>,
	Eugenio Perez <eperezma@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2] vhost-vdpa: initialize state before publishing cdev
Message-ID: <20261101192214-mutt-send-email-mst@kernel.org>
References: <20261011-fix-null-pointer-in-vhost_vdpa_release-v2-1-66ba929971ce@gmail.com>
 <sashiko-outbox-167170@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-167170@kernel.org>

On Sun, Oct 11, 2026 at 10:39:26AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] vhost_vdpa: spurious -EBUSY on open() due to uevent race during probe
> --


Linfeng do you want to address the bot review on list pls?

> commit cef3a58744e8aa0a22f86fbbe577797fa0a78e31
> Author: Linfeng Sun <linfeng.sun.dev@gmail.com>
> 
> vhost-vdpa: initialize state before publishing cdev
> 
> Initialize the completion and as hash buckets before cdev_device_add()
> makes the device accessible.
> 
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index ff7d907191712..6cff1ed2004ee 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -1655,7 +1655,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> >  		return minor;
> >  	}
> >  
> > -	atomic_set(&v->opened, 0);
> > +	atomic_set(&v->opened, 1);
> >  	spin_lock_init(&v->config_lock);
> >  	v->minor = minor;
> >  	v->vdpa = vdpa;
> > @@ -1678,16 +1678,17 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> >  
> >  	cdev_init(&v->cdev, &vhost_vdpa_fops);
> >  	v->cdev.owner = THIS_MODULE;
> > +	init_completion(&v->completion);
> > +	for (i = 0; i < VHOST_VDPA_IOTLB_BUCKETS; i++)
> > +		INIT_HLIST_HEAD(&v->as[i]);
> >  
> >  	r = cdev_device_add(&v->cdev, &v->dev);
> >  	if (r)
> >  		goto err;
> >  
> > -	init_completion(&v->completion);
> >  	vdpa_set_drvdata(vdpa, v);
> >  
> > -	for (i = 0; i < VHOST_VDPA_IOTLB_BUCKETS; i++)
> > -		INIT_HLIST_HEAD(&v->as[i]);
> > +	atomic_set_release(&v->opened, 0);
> 
> [Severity: Medium]
> Will this cause a spurious -EBUSY for userspace orchestration tools like udev?
> 
> When cdev_device_add() registers the character device, it fires a KOBJ_ADD
> uevent. If userspace reacts immediately by calling open(), it will hit
> vhost_vdpa_open():
> 
> drivers/vhost/vdpa.c:vhost_vdpa_open() {
> 	...
> 	opened = atomic_cmpxchg(&v->opened, 0, 1);
> 	if (opened)
> 		return -EBUSY;
> 	...
> }
> 
> Since v->opened was artificially set to 1 earlier in probe, open() will be
> rejected with -EBUSY until atomic_set_release() clears it, which might
> break normal userspace orchestration that attempts to open the device right
> after the uevent.
> 
> >  
> >  	return 0;
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261011-fix-null-pointer-in-vhost_vdpa_release-v2-1-66ba929971ce@gmail.com?part=1

