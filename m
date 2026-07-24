Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24EE30F533
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861615; cv=none; b=sYRxuFFbPhaKfLzrNJt9XMbcvbedd7MXCSMwoAAfSTW31aXJy4ghRL56E61yn4OWlUjnk+WbuOPWdItzpLk6FpUYRupWUWIVpeljM/g7Oo6nw6lii6Hp6TUF4pjUPZML8uh+uHoxPOHBpXp2DugsPesyW7th02QnovegTVjWowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861615; c=relaxed/simple;
	bh=JY1OIkGk8Yi9oDgZ1f0ilcLme849K7C//r+Lciqa1RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHAEtOtnXKoPMqlQEpU2D1ESTUbKyPvr8ykbsQmVif/ebEB+FJrR38qMtbAqG9Z9YQ0BL2h9N6yvCsIDPc9qbUn4jP9aMtSlrLtofW29ALe/dE6Scd13EQ04rj77YAipGs6M4ZSXrMDPwnOx4oHxpnh6dk1gdU4sTrbyippkSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U3aQmLnL; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3aQmLnL"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb7926836eso951036a12.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 19:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784861608; x=1785466408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wH+cMQQWqrOS/PY9xKNIJ0VT0As7nJ3tkEO/JFQ2Nco=;
        b=U3aQmLnLiWB9FGwoXOlMUHcALqH965jB7QEfYJoDwd4O97UrvjivmBWmhjRG41Rwdf
         o25HTUi1wtkOhQHgtsgzicVsUXC0L0mImo3J2iTjsHT1kYqbhpB1U6Lxzua0696CpU6/
         QD1uLPqrhfr3nyyie6PSZWm4oiqiNlAG0pDZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784861608; x=1785466408;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wH+cMQQWqrOS/PY9xKNIJ0VT0As7nJ3tkEO/JFQ2Nco=;
        b=Do12dZZOT67KLcmKhBwZa/3HiqfSYHR74z5ncOh6pmuZmNupUGF4B1nnduqQzL82ci
         AxtJ/ZLgdMJ1MPCMPE7ntZJ79s/1uhjgT4wMiOY9uIebTMVnIp80viz+yjm3Pi4Ov1df
         SuM+g9lSfJ5QbKYAOYFwdwElUXo5YNt3L/8HMub0l0TfQO/f7MfafDXwD1gtRZ5s+tb2
         bXERaSil9+dwr+2rOYAHchOMLyNn6yv5JeELpKOkyAPe8M64UQmMV4InEgTs67nnDMwp
         Iei2TiKwOoYst9VyOEHH6dxGSCmducS5CZbHYywrAkRepFvlvBfX8IFiseQResAWyMGK
         0oGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMaHCVHUQRt/hUMnUCczk4Uh0yzGYNDNDxQ9yBDP05GegO1v5BCFGFfisMSRJ+x5wXks4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpINf9BT8p5sbGcsMoDsld42hNUtFtQlo2auA1LNZMKvfwTAuW
	c833fLh9HfEZMu7PbB4CGjw5BFqgeE/R1d4h6p1NejQ5JlnL2QFi/cNCIH/LKqOa7g==
X-Gm-Gg: AR+sD124be1cTDauY59HSeUK2YVy92VggoUAyJ5jLBNICxtmT4srVlKx3t4epa0TSkg
	xQr2tD6iGktDAzd8B5Zw/ld4+YdLRvNO85ysxkhS42rUnf2NOXdPLcvpoesBqNxAN8neNeQwVwq
	7f7EwziWrm6CzJOk7O6cL71P2FBV/IqiOdmneCb6G/HBsuaiXLJ1pbBrCAINvQAyE8hxruUtSIm
	ZPXtMJB7Lz0RJ3phZTt/ZRNx6yXtZT0AHS8/fS654+dzadCJRUaTFaTlGOELBKUIkT2gRXC5X+5
	5xsYqw9VXv0rV5pHDva9TLWI1CPIbQ5DbnnAWnwUftHLKqlcNRLmgE6R24qcXd9DUOq/Es6U4/+
	xhWRD1OS0+ZHzEGn7mqIliXXd2qDf6nDD3CmmS7uD0HN6BU0SJpaTY5bzjtDRL+lFQyUTMoZ3s+
	n0Acn2pPr8m6/QSrzAXdw5vKhqD9I8Akyxj7BD+PWPxw==
X-Received: by 2002:a05:6a21:3489:b0:3c3:2e2b:29ee with SMTP id adf61e73a8af0-3c44b204eddmr6323311637.55.1784861607702;
        Thu, 23 Jul 2026 19:53:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f18ae0esm3618236a12.16.2026.07.23.19.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 19:53:27 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:53:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	kvm <kvm@vger.kernel.org>, "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <amLPUt59eFu1n25z@google.com>
References: <amG2CyrA-yEUmHqV@google.com>
 <CABgObfaKqT0gMUB_XRP5DW5HmpgaoTgmD-A8_zQVG2Vp5xZE4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfaKqT0gMUB_XRP5DW5HmpgaoTgmD-A8_zQVG2Vp5xZE4g@mail.gmail.com>

Hello,

On (26/07/23 11:36), Paolo Bonzini wrote:
> Il gio 23 lug 2026, 08:36 Sergey Senozhatsky
> <senozhatsky@chromium.org> ha scritto:
> >
> > > Sasha, Greg,
> > >
> > > this is the backport to 5.15 for the above CVE.  The fix was relatively
> > > simple upstream but only due to years of refactoring and cleaning up
> > > of the code; fixing from scratch is not really feasible so start by
> > > applying the patches that are needed.
> > >
> > > Please apply this instead of v1, due to a missing line in the last
> > > patch.  Sorry about that.
> >
> > Sorry for the noise, has this series stuck?
> 
> It had a regression and while there was a suggestion about how to fix
> it, nobody had time to verify it.
> (https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/)

I guess I can try helping with that.  Will require some time and
help tho.
