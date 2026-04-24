Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C693D9DA3
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046995; cv=none; b=MlestF4rCh9WHda5lNZY8uWFwiNmiFisK3VjlqQvvmicTeJCgtBu5XZhhhVAMbT3H5CLN2jfALfbco5vAHyTF+rHp7NbP67OazDmEFhoOiVuxEgqLHri4Z6ys8ZcobW122ki4SE4fe1oQqt74hFJEXMx0WI8cmfqCIN7O8Ipsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046995; c=relaxed/simple;
	bh=2ouheRYAPVivepVFahxoOCkRgEDqPg4oI4DjSnLOeB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHuxM63UHptgPMSWj7WfuNwwm/e9+0qWb8ekcwADN0ookc6T0VYasH5Mqmd2FNbSiVM+2+mkRrk3sl+3UU2vLn8eOhrsndM1EIB6Z/BG03giIg8H2wtWAEql3eoyJ814ZIwEbvt7ojKYCXIs6qxGPW/n2kEJwjcUfn4whKH+ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWaBeHjd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rjw0vtOW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWaBeHjd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rjw0vtOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777046992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1zynltM+qCB1+gf0Itcd03ZQyLMvAA175jbKGHoVBPI=;
	b=RWaBeHjdsMzSJ950NO9DaOZbAglCUIFNjndnTX/9GzGSZz1KVztUVx3VQDCl9yyZ7f68UJ
	KDUX1WfvtdAF5qC1Od4LmFUm1Gbi3Q4KqawfzG9MOnvttKFExiDxHhUGgui8ciMkhN6vcx
	Ua1r+g8L33SkwwNusHFKYwVCDmyml80=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-52Cj8PaZMiq-97ncM0jPQQ-1; Fri, 24 Apr 2026 12:09:51 -0400
X-MC-Unique: 52Cj8PaZMiq-97ncM0jPQQ-1
X-Mimecast-MFC-AGG-ID: 52Cj8PaZMiq-97ncM0jPQQ_1777046991
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64eb0bff77cso12010497d50.0
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777046991; x=1777651791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zynltM+qCB1+gf0Itcd03ZQyLMvAA175jbKGHoVBPI=;
        b=rjw0vtOW27JBX4TIoZ6gQWnCUoFyOnYx/Ec18lgRztIwl8DJSK4dusVvRK32gn3UmD
         6CurLE5P0xv/LlIeAjIUQORf44xhduC/MdoHZEF0u87t+vyE/Z7o5ajJjkxtgPkhPepI
         rzDRM+CdNpMZgbgG6DE41dWO5DF5IgGsCqyDiSxBciJhDoJmMlvGlhta2YU7sFD9q0CW
         OV3q/VMi8T16ad3Fwx1PloCdTbAaQ3qywmO2rIjPVOTIPM4dExfZEjUGTJzwmcBAB7NF
         EuAeI6hmWXYn1M+4DNYkZfuFkFrnqBSL28pb6UIkZ2fTTIyOEJLWXLpT5iVRT/jdLDaT
         XZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046991; x=1777651791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zynltM+qCB1+gf0Itcd03ZQyLMvAA175jbKGHoVBPI=;
        b=tZ1p2IJaaeRqk3xymoL8+T7qT7Qzp3CxcJjLZvwQ7PvGmGLRVvlYp/wpZ/O5EnrRd6
         7jX/bktGHYM+ZLsXYEemLQvoE3BO1WdIOvklXeCEjlgsc412eImB9g5I1sVU53Jm8VNX
         iepELuByLECmsXdUwwglpawsfSyWqa7ziKCKKvxiDVr+3kyVMAaTB/LZbf2DX/qsmDc0
         0CxU1Ik6La1rz6GbIwEcrEuHUkNynmDHl6wnqoXmsCpR+0INKTYTh4bIzuk26e3IQ5R4
         4RXgFmS38+p2jgcycGgzI/Fu/52oPi0jWs18rcdcZFt1ndIKAgm+EBTZrLppHrwpPYT+
         tVDw==
X-Forwarded-Encrypted: i=1; AFNElJ/s1SVziq5T8n3YXhPX13OuCdrZiot2mC2KNDjDf1EPR9zofuaR4mDs60DcHfq9boJF+xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Yc7PHTOIFDQYuBnYrIEMA6Lvh9x8MI0l4safs0i1l5SxbCiY
	Q21JH+18uJTr2PLoVuhYETqefdkcwYuXK61W8Bw6e1eA+OBXZqKwVeFRa+hbLy/MGEPcjXLf2Er
	4Vf82jf69RfEKtDjxYfAFlkrpzNaW06dyxCyu0+p3SbSRuXk4fA45CA==
X-Gm-Gg: AeBDievn5ZNbPTZE6Xi8vB+O2oWcFGroOZ+hI/ovfDtfrn/pGPMVnDhChlpXlLzRWiJ
	kASRlxOTGdEAC17+J7ELQh42PY+xLvSlGlVJkpOUYLloIF2FsgucktLtTbtH2elOOSJNaSPX95x
	dvqbkvZ/X4I22AHxVxjwU7xVL6COpRI/6IHEgRS2zQqnk3HnZLmqdKOmYkRG6kur+vpz/rv9690
	tgrTXKTWQAvmPqgWL+YBUQtMR24Aq3e0B6MhQs9Us+i6XBNYwQ8wLr2L7qKGy3ow+k/2WUFDPDp
	95xck4RKx5V3v9CzbrOcV8m1vac+aRRy4mhdqXi8L/uA1uw9+eWzsWKYCkJHg62KkT2nP2fQnlu
	W6z3Q+ESMXm7WBTw7TeiKn+OaJ8zr5mHrYlC0I3DWIR+2hxKyJUmZXKA6pw==
X-Received: by 2002:a05:690e:419c:b0:651:cf84:7744 with SMTP id 956f58d0204a3-653107ebc28mr25160567d50.11.1777046990847;
        Fri, 24 Apr 2026 09:09:50 -0700 (PDT)
X-Received: by 2002:a05:690e:419c:b0:651:cf84:7744 with SMTP id 956f58d0204a3-653107ebc28mr25160511d50.11.1777046990305;
        Fri, 24 Apr 2026 09:09:50 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm191939006d6.30.2026.04.24.09.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 09:09:49 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:09:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <aeuVzCUJ1P3pL4rD@x1.local>
References: <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
 <aeoxnuGKO3uqS2kG@x1.local>
 <aeo5IPpQi7onyjTF@thinkstation>
 <aeprnnccJeyHB2rt@x1.local>
 <aes7b17nG0cXrtEd@thinkstation>
 <aetZUOINzfTXChLL@x1.local>
 <aetyhki-UD70dyRL@thinkstation>
 <aeuSe0PY-g10KNUF@x1.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeuSe0PY-g10KNUF@x1.local>

On Fri, Apr 24, 2026 at 11:55:39AM -0400, Peter Xu wrote:
> For us, we know the overhead in theory, but we never really measured how
> much.

I think I didn't discuss the other side of things, where hypervisor can
touch some pages and mark it accessed, even if you don't want to.

IMHO we should track most of such accesses, except special cases.

One example is when the access happened because of emulated DMAs, then it
should be marked alongside to the guest access: that's when you mentioned
vhost, and I believe whatever vhost touched on the pages it should be
marked hot even the guest didn't touch it.

The special case is really migration that I can think so.

When at this, I also want to know whether you can benefit from something
like swap_access() / maccess() that I can propose when it's ready.  It
means we can shift some corner case accesses from hypervisor to that API
then it won't cause false-positive even if rmap is involved.  Then rmap
will be a pure perf issue, if it will still be an issue at all.

I can also share at least my plan on our side, in case it helps to find
shared goals. Basically we at least have two ways to go:

Plan A: propose maccess() then use it in qemu for migration purpose.
        migration is so far the only thing we want to rule out.  We want to
        keep DMAs access promote pages, for example.  This will keep
        relying on kernel to do hotness tracking and evictions.  IMHO the
        best and simplest solution so far taking both user+kernel into
        account.

Plan B: if above didn't work, we can implement swap in qemu.  We need some
        API like what you're looking for, except that the major challenge
        to us is MGLRU compatibility.

So IIUC if you're looking for completely flexible swap backends, then Plan
A won't work for you: that'll always stick with kernel's swapfile
managements and it's not always flexible enough.  Then I want to look if we
can share goal in plan B.  But if we can find some shared goal in plan A /
maccess(), then I'll also be more than willing to know.  For that part I
can definitely see what I can do.

Thanks,

-- 
Peter Xu

