Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557B3C343B
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609345; cv=none; b=CAQqFhMt3U15cNAyK3m39NF4pI3Fwtz/vSA2xhcJ4npWnOHlV82LEh7BhkyGvs4nZtcIFr4OdCXCn0z4l/3HVtXlfB0X5sFISHtjFkNKPcux+vrB7KGRgv+8eHdmJklJr6C0q4lXjwF83tI4TIesOuVDoi/lCqh+qmdjgOZSmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609345; c=relaxed/simple;
	bh=DEELFafNs02o2Jw8wwwve5YVLFMnln12tT6CJLWenpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVE84CYcqzXu31+bdotQ/0nTeMV+NIHuI+L16pVzd6YCe5bdVspaePWudlGF3g71LzTkW89NoTz1aBPLJcYrqjAuYmlkmPHqaIbXvY1G+9SFcQrsqZjkyxWrFBXMpnYU/mZQpAqFdM1vjuwhdXlCQdda4TrzZbHNVlkZTdUGQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyUuzlb5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyUuzlb5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8422f395a4aso776806b3a.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 14:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780609344; x=1781214144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rclMFJrL8KGejCQ/7MPzYir/Jx+VDW8hyRVGOEBc5TU=;
        b=hyUuzlb5N9PxXrkveXkeMWW6Ag9NdrHXA5lWwh+0IMtOGtAvtzKY6/P8gh0Emffiu7
         qinJywLBsdOkEX71d7cSLBcGbTPoGrtxbnJKCft0PUPstpZtmNMplnOSKBfQpAKItxlR
         +g0Jw1Twj8uV1V77U2WKI6fkSNQfxyrNry8BiyFre92uGoqN/9FlpiuNt4/9IMrLrJqY
         d8wMqfWfVfLwpV3730bWWY+ve0M15vmcDgNxRTY1qyMvx9AC87i7VkBnKOopFkiy/wEI
         ERpKszgDCgN1RzE0EegDDkK+XO8uKeBj29KkCuN6lPCPwVpQqsUfYZ+dP71B7J6zyMV/
         i2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780609344; x=1781214144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rclMFJrL8KGejCQ/7MPzYir/Jx+VDW8hyRVGOEBc5TU=;
        b=qNovZVg1vBcgQHm58ZbTTdV5IGOZzs0RTqm1AQqNmlVcDzQX66t936UJDhg/gH9rh0
         tJihcnQxXDndH6yvTLZdZ223fkrH20eGcbBF1gmh++cGLDlH1n+Il7sfO9uPWiVjNcP/
         kYuyWNPQCbHtf2qsTfzwMo8hY9qyf//K84/qWWaEYBjOsU6w/a4r6a3nfbzifoRa9Gs4
         LuFXVzg8TW5vqcGZ2xmF2Ra3StuYrjfAZHrIN7gdEeSGpoWpZ3l/6RnWOvDwJfqXDhcQ
         GCMPkImAdewsCOk2B5slvOz/7siGBDrNcUkRBPEFf7BbcqixWAwcj374Jfb5kboVLbCU
         57oQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vHbzm6U95DtQqPWGQk96tYfD0aR5aPopuUE2B4xsowO2nL8sjzwxkwFowJ7/cB/hZS7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzsKeDJoKfOXGLZdvReBJGVJJVDp8SoUp+bSdqbFdXDnKTa0h
	dFoisApSBhyAPjgjGwE2T7aSpcOoyzEUMQIGKsNC/kSSdlNjL9DHXuiA
X-Gm-Gg: Acq92OFy0tewXjq1mrYcsb+FyAmQHT+tPvwlx6WKtN5dozzgnCwtWlvvJthA0vup6Ha
	cAPaBNzxF2xOXo/hvCXJVBbena21b0TgpOw3+lMddunZRdQhJ8h/jY6vYzEcf1ETyBwu3AO3Hg/
	plxlTL/1014bsmsYCIkDr64FW48cu5r0ybWHHWymzQzl5xHl7Et7frRMD1HtPevYieYzn87iX7H
	ab1kXt6XNmfyyihePydaiZCmssLjYgg5+18yUL24vDDYb87see+0JnSNPAnUsHMinL3Qj2fTWkP
	eblgQNjotYi8lWaDD5o4d8p0l+Q+cX9cYKvZ5TGXft+1KPsj3+4QSGS1dFrvCFkgUFHTif+fB3+
	dl0xJrM6rDRORP8My0ympZUuGeHzN8tR8b7pC/IZt6onoXW8flLDHDgI+BKNeT3Ec61sH47iRjy
	n7noivWis5dbpXwQNro+n/zmrxpOcTMev0r9NPaUH47dy2nL2b6budAA==
X-Received: by 2002:a05:6a00:94f6:b0:842:3804:590d with SMTP id d2e1a72fcca58-8429b57948emr4143096b3a.7.1780609343837;
        Thu, 04 Jun 2026 14:42:23 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282918b8csm6769086b3a.57.2026.06.04.14.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 14:42:22 -0700 (PDT)
Date: Fri, 5 Jun 2026 06:42:18 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: paul@xen.org, seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
	Andrew Cooper <andrew.cooper3@citrix.com>, imv4bel@gmail.com
Subject: Re: [PATCH] KVM: x86/xen: Read long_mode only once in
 kvm_xen_set_evtchn_fast()
Message-ID: <aiHxOgVLGyQ2fa61@v4bel>
References: <aiHPPUk5DY7rH-zL@v4bel>
 <c6fd97fa3e592c3c3734920e1a45f9af1a389a16.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6fd97fa3e592c3c3734920e1a45f9af1a389a16.camel@infradead.org>

Thanks for the review.

On Thu, Jun 04, 2026 at 10:01:01PM +0100, David Woodhouse wrote:
> On Fri, 2026-06-05 at 04:17 +0900, Hyunwoo Kim wrote:
> > kvm_xen_set_evtchn_fast() assumes the port range check in max_evtchn_port()
> > and the bitmap layout selection observe the same long_mode, but each reads
> > kvm->arch.xen.long_mode separately. If the guest changes long_mode in
> > between, a port accepted by the 64-bit range check is handled with the
> > 32-bit layout, and port_word_bit falls outside evtchn_pending_sel.
> > 
> > Read long_mode once on entry so the range check and both layout
> > computations use the same value. Since max_evtchn_port() reads long_mode
> > as well, compute the bound directly from the latched value.
> > 
> > Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> 
> Thanks. I think we have the same issue in kvm_xen_schedop_poll() too,
> don't we? Just slightly harder to see because the bitmap access is done
> in wait_pending_event().

Yes, kvm_xen_schedop_poll() needs the same fix.

> 
> > @@ -1809,7 +1810,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
> >  		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
> >  	}
> >  
> > -	if (xe->port >= max_evtchn_port(kvm))
> > +	long_mode = IS_ENABLED(CONFIG_64BIT) && READ_ONCE(kvm->arch.xen.long_mode);
> > +
> > +	if (xe->port >= (long_mode ? EVTCHN_2L_NR_CHANNELS :
> > +				     COMPAT_EVTCHN_2L_NR_CHANNELS))
> >  		return -EINVAL;
> >  
> >  	rc = -EWOULDBLOCK;
> 
> Rather than open-coding that, I wonder if we should make
> max_evtchn_port() take "bool long_mode" as an argument instead of kvm?
> Those callers which only need a single instantaneous answer can just
> pass it kvm->arch.xen.long_mode instead?
> 
> We'll want to pass a 'bool long_mode' down to wait_pending_events()
> too.

Makes sense. Shall I send that as v2?

> 
> To be clear: these are not security issues because we'll only ever
> scribble *within* the vcpu_info or shared_info pages, even if the wrong
> places therein.
> 
> I'm actually more concerned about what Sashiko saw. Xen does enforce
> alignment, so we should do so too. I'll take a look...

In addition to what Sashiko flagged, kvm_xen_inject_pending_events()
looks worth checking too.


Best regards,
Hyunwoo Kim
