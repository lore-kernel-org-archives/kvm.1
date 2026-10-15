Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F94A4EFA
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050881; cv=none; b=p6ey0G4isgXKTz6ErVR4iPZqF5+pS3rd4Nmpd36I/3R9RWD9JwUUTgHzKKKVZ6Ri3zruB3dXUGKEyuy1P4CDApFARbroGwBSSNw9dJBJWfapHg5/7Il1tqP5xEkv+DV05i9hF/62C66BN87MJE3c61A+vBWCTKBuLg08mI4MUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050881; c=relaxed/simple;
	bh=CS6nSalvLuDJ2YWqH3VQWUdSUG/gi31LAgs7222BpJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCnnWckvsT4oVT4KuKi+fwaIqCOFmQlmERpzh1vxr1BNK3zrR+1yIgsLpxhcul+Z15IqYLBbNQ+m1iJ6u3EQs61b+RE/PPRgRllom3tFeiAtzDE5JMNYVAXuYHAuCrdCoBR/OirJkBW1Zals8CJfMo5DT1hhFMVy8X7l5RTx2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJE07XKD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5QlMaTn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJE07XKD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5QlMaTn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792050878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6twZoHnabfZa9E7zwB119jg5IyCAwxBQB9uv9orm0o=;
	b=VJE07XKD+U+ZbBqm91GQ3ZN/aEy6yEMeabRNSWu+Jde2WUCcyNMNuoc60CQdQZrqPLixXB
	1hcZ2pbBTaztFhess9XIS3CWVyI3zByb1w4v30lv/xNQPstHaFJKLgWMYImPUYW5E8CyOs
	pvJMFD+kpRqLK0HTPV1J6tqEv54uEqs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-ilX6iedpP8-isVXjHY--Qw-1; Thu, 15 Oct 2026 07:54:37 +0000
X-MC-Unique: ilX6iedpP8-isVXjHY--Qw-1
X-Mimecast-MFC-AGG-ID: ilX6iedpP8-isVXjHY--Qw_1792050876
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17741243eso11376975e9.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792050876; x=1792655676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l6twZoHnabfZa9E7zwB119jg5IyCAwxBQB9uv9orm0o=;
        b=E5QlMaTn7TgvIeIFvm8bjOhyCz6tYWdp5BKqXJO4Bgu+TX7BOsm9fs3v2Es8NF49ko
         BD53NsOPg9+jsbZx+lCE8pgU44P39YfHogYHRd8ejx9RA/6567QLSi4IDmNEvbQnZowb
         3H4ozz1wNUT9S8RPH/yA9h4sxZwodtTcli+ZCBL+giuHJ+UB1kBLmpK9R8AObvgaiWip
         yFrD3X24ox4PgvJDk1++169eVXqV6z1W6PukKPKnnF1bMOQh0zgEtjHYymwIeJxOPDJ9
         ddsRwV0xusGluIWMLXxu+bRMtG6b0+qpK1U4nuLv/DX/TOUTRut17NDsXmPbZ1M3GLpn
         K3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050876; x=1792655676;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6twZoHnabfZa9E7zwB119jg5IyCAwxBQB9uv9orm0o=;
        b=O9gqh3ZoE+SCjLETZczUI8EadSsFYEfYPsDqarlZpEH7zpFjs3kVw084rskt/faprW
         Jg0biBW/FusW3rR/cgXSKiht+hwDu1OKKoJXCU7+3Dtc7vAfC0e18cU1JlxuwosbK6mH
         A8ShT/PkkdVCSB2cCnNMYlqWZAiPRs1Qp0TYxWSB5VnKC1mTroiD5CJIyHXcplWC5q08
         ngRLvINh0GNNUgBNmB9H+BrUKiyz25TAioNdyA4kEQDAFLSNdQlrK4FeMnU+cDrOhqr9
         N0HHG3Km5GZe0tx5O2ndTehVsSsJRFTn1yThOI4Zso5mK1rPixuxr1JdA9p60N3MGwce
         sW2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzqThMGQZHFAY85/RT+o9+XeGoTd62bCft8h+m/m45yKgekPy84xqp3rGH2EVvqeJmRNwA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFUGI8QYvL1JbqIV8r+3WiC0w140UZV9+FJ1wrttXQNtrY6ibK
	DHxwU3h83jglBone0UWiv/CsXHd2aeOrAT6C3jPBxyjtPieNg+6zgh6Pnw0kr+1o7BN4Fdr7fzN
	jvBSvHaKg2RaXpfgzryCv8TSFbbSpuMhxKQFRac0EvZuPAOuuERqnUA==
X-Gm-Gg: AYBFou0trn6LCIy4toqiBsy5XYM1cs/nOKUm2vGB0BXEsWzD846yS2J3gAsGZfol+R9
	5mhOLrLbsjmFyj42mgF9Qvs2Wf5GnCFznNy5RYuLRz9cvcJiDHJr/GJjq7TnIzU6hiS7neCGPHe
	zEWUa83YEzKBVt1o85jXwZ1PNUvhjz7yNJJw2ffjpp2pkNBFRWT5qTkL84QFy1RMD+Gg7PcP5//
	O0ACJIIfE7usAv6yUbr7rAEFmYEB8fd0vYloylIqBAaRmNTeJx1Cr85dyP9WuEigbtTgSFuWASu
	U5VsxQSRW0V00K/ti/5pG3mtdvXhS6AlGrjPT3JqEEWJBukk8B6vX7maPSNqGCWwmwFc1wgxTp+
	NcA6zGIUmccVKwdBjVlFhi8QrUJ5X2nhkX7o=
X-Received: by 2002:a05:600c:3d96:b0:4a1:746e:5898 with SMTP id 5b1f17b1804b1-4a18e4835e7mr319120215e9.13.1792050875931;
        Thu, 15 Oct 2026 00:54:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3d96:b0:4a1:746e:5898 with SMTP id 5b1f17b1804b1-4a18e4835e7mr319119865e9.13.1792050875579;
        Thu, 15 Oct 2026 00:54:35 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbace19sm52653635e9.14.2026.10.15.00.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:54:35 -0700 (PDT)
Date: Thu, 15 Oct 2026 09:54:33 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	"Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] igvm/sev: apply the IGVM guest policy before
 launch
Message-ID: <atCGn10gISek2sZE@leonardi-redhat>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
 <as-gUPOHujXsPiWV@leonardi-redhat>
 <atCFVaKiSIvz9uVS@nucbdw.ghoffman.csb.home.kraxel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <atCFVaKiSIvz9uVS@nucbdw.ghoffman.csb.home.kraxel.org>

Hi,

On Thu, Oct 15, 2026 at 09:50:32AM +0200, Gerd Hoffmann wrote:
>  Hi,
>
>> gentle ping :)
>
>Any update for the igvm command line patch which needs a doc update?
>My plan is to bundle them all in one PR.
>

will send a v2 later today!

Thanks!

Luigi

