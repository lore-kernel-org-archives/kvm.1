Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6783859D4;
	Fri, 12 Jun 2026 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281044; cv=none; b=FmUrpjySnfnWbbuLpyOCArFZrsEYYw7YDMTHp6J5emg6lr/H1M7w3ZtVp1Hl7cqB+RI5SdSdXtpfWhO0MaejfrlwvI7S4OpxTYU/QyHyeDzZjn5Wmc5jCR1z2LpaiRYml8fnjApLMOnkWo5cRnJL0ZwVM/mABrSf3A5iDa3qQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281044; c=relaxed/simple;
	bh=UU/ogLn6xBIX27QwU6guz/GgW6u2WwjYlw0dZ3ftIKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk3upGLFpa0v3f7eaH7nmchubQn7zz9TrtTonV7se5owpKUz3978c8NohVBiwJAxkWxGwMgjlizEzljh7BnHA/iaMurmwpcxfUyaihgnvwjvNOAPjFVX24UPrscD1chngz2d8IMjAIWWjyhVcVl6Wmrh0brArjISQXXFtA4G8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=SgnMTN7i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YOTvVUq2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="SgnMTN7i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOTvVUq2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DEDAEC01DB;
	Fri, 12 Jun 2026 12:17:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 12 Jun 2026 12:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781281042;
	 x=1781367442; bh=1vhXUJZQhNE3EHCEs4/ydOaNQVc8dma8V8v3ivsvapM=; b=
	SgnMTN7izu/+d8SOgVNa0rkaiLuHRcYhI6Cx7+heSCWadAm9ElwfIySEsQO1wRna
	DQdOxgenHKmX5MgEqmH0oQgZY2pJjlzO53Wj87FQlSg7I1ZuMktiQHZA4TpeuyzX
	x1Ez0RWqjMUcO8hJNKCD3e4dsdC6F6xs7jwJoN5VVBWmwsmInrq/4O92mcFHE4y+
	v1J/TFdMX1jehjuMwQQftKAi3ZgZNEscigogPgyefYLoNezN0At7g+ZSWITzPnAT
	5uxTqaUgiwjf3teqXYS+1DZMxxLPp4ca5n1C812PdwaO3GiiI38QvCcWLslW+Fan
	ksXj110X8I7Ifd91nHIGKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781281042; x=
	1781367442; bh=1vhXUJZQhNE3EHCEs4/ydOaNQVc8dma8V8v3ivsvapM=; b=Y
	OTvVUq2wbXistqMAd1aZoZwYIBeeckz5YKWP0Ksj1uBuHXEPksTvsO0GWekxRVtZ
	BqWeLqrC8gGZYMXztkf2YelBEuyKE0c0p7eQZ/RdQhPb/lIkYPHG6xlEqyomArzl
	c/YJK3UaksI6SVXH1ta80kLSevkXmwj5EE3/408VEYcRrwkCLGg8Sx04s3nsK+A/
	Eh2XZP6Y05S0/KDRB6oJoMxY2MjPP4DPXOcbiZoPEU7D9SO/wG7k+5amIAr+NJLC
	LghYhaqDSuLX5/MM4aj0OcP1u12K0qVVlo+iG3WcjG8t5sFo+AN83yAygavfcDG9
	l8yl586rFyHbfBPgp24xQ==
X-ME-Sender: <xms:ETEsagBmtqXs7KELJ4IHUAP-P7Y5l_SxKTTAWf495MwZs3EszT_mAw>
    <xme:ETEsajPc_ATh0NKBd6IKcj0V3uLHD3ePNeGQHl5tJyV_PombIYHZ7CUhoRNHFRWKI
    Kq98G9_wgI1jUmUXzqUTZQpYSxysOY0qScNKXPy4R_N57nU_KLAbQ>
X-ME-Received: <xmr:ETEsahxoOM7_OMRZnvwz1x2zyJamRhoQgyQjWOn8K_q8JSwIdpzkqdRda6A>
X-ME-Proxy-Cause: dmFkZTGWaC3Mgj4HhqTR0v7+eaqtc/2aSq9tvzt95NbILfuZP/yMW0PhzzQalP43J1PjmU
    cfgLbj46ERx3qSkw0F9r+O9JsBixEWFX2ltfrbPIStjoL/exngtmp5cCVjMq4wP0eO7cV7
    cei8+adsb/UXMYE0pHEFzHmbHkewDmSMs/OOqubNkc/TMdbk4bh7Rc3VDQ+4vlurd8ncQT
    zuj0wmUNMrLEDy0PCsGa0zil8GmwgtOysMhnfgbWRrUZndpLjgUSfwkRyhNhTxZmbZeJey
    FN0K+SYjsXO97BXwS5DuZdb8Tfb/CtD0IwMqqCr6ScvpXQGq2pZDwfZD65vm4BqmZe6JpX
    ZYgQXZTMzonAFn3oullY1i2ML6Xhl5vL0jRKuDwPKdmhSSvwzOuIg6QRxBvj1AoqlsTqs+
    rpVnQG5JzUyDnoz/m0PtDXl+m0XGMwkSb4O/5tum/F9ZVfMHFLFitQl+V0zHTU2BM8igFE
    Gz8v9SbKtofmeIg95uX/bDKmZfJp5pilocUiNHAthv/1Dg5J+XkuLsl8Gt+QSdmUH7h0ah
    YNT13xzEE/vq8GjuEz/ml2XwWMl94tJEgoAfItGwhnQU1OKD19BkcKmxD47Kc9Ia+Ltw/x
    +ymXVa9Wb1am/LJF0ShTDpt1G/nQlKkFiE86rPinZeKdGAw4LdYOWxsjKUEg
X-ME-Proxy: <xmx:ETEsarXbqg-VQUPhQkCftEjIII_t9xjaEX-WtjY0leejyq2rbPxAsQ>
    <xmx:ETEsarOF2iHn8zsUE7LsDkpTe4W2F80VKznwWaVURwW9OBuD8DdHYg>
    <xmx:ETEsalC6lscLQBEPpZ4uV6pj1RufGmPag22HPT9IPs99-o-AlhaYAg>
    <xmx:ETEsagfy3RtVuyTH_J6cORaSBQdZ4uURF5WId5oMSW7tiX4s2T9ZNg>
    <xmx:EjEsaqSt-cI2B_JAg9n3y8gUUXqwH5SfAEcibyJ3HMTADfygPQDyQ-gr>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:17:20 -0400 (EDT)
Date: Fri, 12 Jun 2026 10:17:19 -0600
From: Alex Williamson <alex@shazbot.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com, alex@shazbot.org
Subject: Re: [PATCH] kvm: vfio: Convert kvm_vfio_file_add() to use CLASS(fd)
 and guard(mutex)
Message-ID: <20260612101719.02746ec5@shazbot.org>
In-Reply-To: <20260612101530.7b8b8edf@shazbot.org>
References: <20260523050242.41472-1-yashsuthar983@gmail.com>
	<20260612101530.7b8b8edf@shazbot.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 10:15:30 -0600
Alex Williamson <alex@shazbot.org> wrote:

> On Sat, 23 May 2026 10:32:42 +0530
> Yash Suthar <yashsuthar983@gmail.com> wrote:
> 
> > Convert manual fget/fput call to CLASS(fd, f) and
> > mutex_lock/unlock to guard(mutex).
> > 
> > This remove the goto based paths both out_unlock and
> > out_fput.
> > 
> > Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> > ---
> >  virt/kvm/vfio.c | 37 ++++++++++++++-----------------------
> >  1 file changed, 14 insertions(+), 23 deletions(-)  
> 
> Sean already took Carlos' series[1] that mostly 

Sent too soon, [1] mostly handles this, only maybe the CLASS change
remains, if that's still worthwhile on its own.  Thanks,

Alex

[1]https://lore.kernel.org/all/20260313122040.1413091-3-clopez@suse.de/
 
> > diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> > index 9f9acb66cc1e..bb3694d9c0c4 100644
> > --- a/virt/kvm/vfio.c
> > +++ b/virt/kvm/vfio.c
> > @@ -144,45 +144,36 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
> >  {
> >  	struct kvm_vfio *kv = dev->private;
> >  	struct kvm_vfio_file *kvf;
> > -	struct file *filp;
> > -	int ret = 0;
> > +	struct file *file;
> > +	CLASS(fd, f)(fd);
> >  
> > -	filp = fget(fd);
> > -	if (!filp)
> > +	if (fd_empty(f))
> >  		return -EBADF;
> >  
> > +	file = fd_file(f);
> > +
> >  	/* Ensure the FD is a vfio FD. */
> > -	if (!kvm_vfio_file_is_valid(filp)) {
> > -		ret = -EINVAL;
> > -		goto out_fput;
> > -	}
> > +	if (!kvm_vfio_file_is_valid(file))
> > +		return -EINVAL;
> >  
> > -	mutex_lock(&kv->lock);
> > +	guard(mutex)(&kv->lock);
> >  
> >  	list_for_each_entry(kvf, &kv->file_list, node) {
> > -		if (kvf->file == filp) {
> > -			ret = -EEXIST;
> > -			goto out_unlock;
> > -		}
> > +		if (kvf->file == file)
> > +			return -EEXIST;
> >  	}
> >  
> >  	kvf = kzalloc_obj(*kvf, GFP_KERNEL_ACCOUNT);
> > -	if (!kvf) {
> > -		ret = -ENOMEM;
> > -		goto out_unlock;
> > -	}
> > +	if (!kvf)
> > +		return -ENOMEM;
> >  
> > -	kvf->file = get_file(filp);
> > +	kvf->file = get_file(file);
> >  	list_add_tail(&kvf->node, &kv->file_list);
> >  
> >  	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
> >  	kvm_vfio_update_coherency(dev);
> >  
> > -out_unlock:
> > -	mutex_unlock(&kv->lock);
> > -out_fput:
> > -	fput(filp);
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)  
> 

