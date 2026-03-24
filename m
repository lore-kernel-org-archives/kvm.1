Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533C7081A
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316874; cv=pass; b=MNOJui33TxvZeJ0rIAimOA0XtJvP45efz3W0juZSv79Kt5LfCve9nZb7i3rHDKbWm5KgDgEKKhbzAsAEkfRzHM28pwkQC+BmD/E3W+FRtE6g8u8qy5P5qWQY2VRQ2Y2p4wXgYtKITnR0OswHTOrnwV3xR+ERfC/KW56zRCznrZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316874; c=relaxed/simple;
	bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCWHE34z5HqK4yYptbqhAC8dXarUMXG55GFlPVl5LV08/oY2/qI9QtEve/Zru1Y07fyPhFPWZ14Gd5Vvxr1d9toZDhjVDyGNRbf0ojN+zpNrm956HNYKzIofScIGsgzaIeLzgzkh56Kyjcnthk3emSJVBue4k0uHkCwgBZMnz2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQe2a/Pf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfWHNUP4; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQe2a/Pf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfWHNUP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774316872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
	b=aQe2a/PfOnW+V7sV7pIE9fqAWjFo4Kdpqga+ZE9Cq50XatTzpnOs8n9nyQ8mpCJ+jenwGH
	iiNjUwhU2+UScy8vwNcfyEqLy/PUexbqYgrlx3HkXed2ApTh5wosKIipJKl36/mIViO7AL
	xgTLGrrgSnPP6wI8s5w3mNEGd/VB3EM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-sBT1kiHBN0i1og5OWNprKQ-1; Mon, 23 Mar 2026 21:47:51 -0400
X-MC-Unique: sBT1kiHBN0i1og5OWNprKQ-1
X-Mimecast-MFC-AGG-ID: sBT1kiHBN0i1og5OWNprKQ_1774316870
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3568090851aso11376826a91.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 18:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316869; cv=none;
        d=google.com; s=arc-20240605;
        b=TcGdVyivJiCMkvKfswebjHupVWuG4qX2JawwvJyQORBiy7p6M4JYqFwktp7gHx1Kz5
         vWnq8MZIwp3rpUvmQgBZIm4qrzDShmi6c4F7bZrS7lbyBXKTWxrnMwdr+pOWregHYZHw
         fZCuX9kVe6lfNrATCDaF0w0bod0G4bxnisnYlo7l1hywFGKA5g9DLm7W7dCUfeGG6Jqj
         ZSPqW1/hEO2fJfUCmlDu/3tfz734mL9+NBkjuCLo16VyT/0KrGDNoUQDUgEbpNuucC/j
         0n2itK5KVksFiEYKgv6zkdlXiM4EIMJP8v91zcOp3OVS2xViJwC7QS0bnn3Mhs63k42Q
         rK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
        fh=0nms9pDzv2EF+Elgrp+H+APuZC4wAvvMO7mopDjiEP8=;
        b=lNZHPlMPeKOwBX3KTMdnW8JBukDPxAhksdnYZL2Tf0I3VrxZtpY2bOAimEblqERaJo
         6v/9Grm72faHjjdO5OXXfv9pt8fq2j7Hd3bLuaqQOhQWT3GhJrPVLClaFLEBz1m2dVFQ
         Pt91zguzMdkdkg3BNwb/5nR1paOyNxfB7cDJTqww0Pko/OWSF3PqMqUb5aoIW9DJA0rd
         kaa8w6A5yYzC+gz1dDra9cV5/bO79bEOm0All682FEh8lWceTr2THEJuwEIu6ZbX5car
         sQrXzR9JGzbYfym1vv7E7NyM4qwvl4WMAmfHGnV8G4/dnCFZzJOOdVNQOWwcxaVX1GkE
         oGFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774316869; x=1774921669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
        b=SfWHNUP4b1MMlckkVihIB+FChbQKRI4wqOk5tUwZfrJG8djvzXr3rbFUsBVq5SCSY5
         e432wso4yTbHHFy5DAQwc8/FM7gIBMjGJekHQy4mJ5vtNWyBT0h7HvsprHMYqg1CGBT8
         NFdbK4KBmqS4rqzgJRCavFrhTImcDICgsN9BY0m9q31D4N14rEST0ELqJddkymWthX+q
         DgwmWBjEg300y1v4kdA/idHeK+aO3UCo8gP0c3mYFJUHMPFiNYUyjtjNaL2SwuL7Gan/
         wnJJRjVxDct9p6flx+oz3o4wQawJEwHP5nta5QiCKuMEhRCSXNnNtnIQdO0OGws/NNIn
         tCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316869; x=1774921669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
        b=gIxWDQWqzqyLoIKafyKnHsya28wf7hLo+koRJ3Trv4vbnTWk+sNyg67Pv7TKA0RD/J
         OJqeGN3Yi95N9uNmRXCPKjPFPb+5LxnAwOAVGRj5DTQPnydyK16QbuJLo+SVr91JyNoi
         tE8J/RMHyu7aVL+X6tLUEI3grExSkdubwH5QmdeQcJ+5Y6srZg666X0XSEjYz8kg4eaz
         GK8/R+JxnQDnaUKN8LvL/eTCP9symtQPKs9bliTf45S3TXMwEi4nEax/pII70RrQjaAV
         EfIq4jd9HVuutojUMZajSBy8XhLKWtGidEhdZ2k2sTDF2zDFPEPHLCECcrgubGUO+Er7
         q3UA==
X-Forwarded-Encrypted: i=1; AJvYcCXPdwLssTJQyAUXmAEmtTLgiq1cdqf/t0a1hCxq5Uchv6mAj7XiWqLmfjjqcqKyRlelChk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSfzjBdcqFNaBEgcq6eTLPWJ2ysT0L9oNDBBQMoV0roHBmnlr
	xubZCnYUI2rL2OhFr2u6f1EKJknx7pk8AQqFbC4EDtqUTZPY2D/C1Ajzowfp+x34ZS0IyMONjSV
	JhrUlEb2tKs+P+8rCMk6uDEQ/R1LoxB6xhhgKESnUJ6HFQKM0PH7QhTeUNB1pLJXOsJLeMf7jhN
	IM4QM8r4HysFtZk49kIJaLdd7vi+kqjzOTunPTyxs=
X-Gm-Gg: ATEYQzxguDrUN0Sry1YEieMOrI11hSWriRnDFdxnLzjKQ9Tp1vdUefGgW3jI8cJq4cG
	9SfCrNYuIK8HDDc/BhmUbPDLZQ40iS8g9mABb6DAOfJAQSlnYhp59OOg/f7hzs+Q2zgT6F8jdWE
	Wk32uc1z8CwS69C3+KEIVVpyV/7QgSkMFJ++V8wz8OHJeVBvUienehRgdqUlwHM8Rldh2whB2TD
	WtpUDE=
X-Received: by 2002:a17:90b:35d0:b0:343:7714:4ca8 with SMTP id 98e67ed59e1d1-35bd2c69ef3mr14096614a91.15.1774316869499;
        Mon, 23 Mar 2026 18:47:49 -0700 (PDT)
X-Received: by 2002:a17:90b:35d0:b0:343:7714:4ca8 with SMTP id
 98e67ed59e1d1-35bd2c69ef3mr14096600a91.15.1774316869084; Mon, 23 Mar 2026
 18:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-2-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-2-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Mar 2026 09:47:37 +0800
X-Gm-Features: AaiRm53pbYbqwGT5VS_08JhQ1nrnThR4mTQx66_GOYMi6H_pXUhKS9fZsNHeN9o
Message-ID: <CACGkMEtYD8OL-4XyEFaa4hhBbki_zmcywkqa7Bd-1J2ZMB8RoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/4] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
> __tun_wake_queue(). The latter wakes the stopped netdev subqueue once
> half of the ring capacity has been consumed, tracked via the new
> cons_cnt field in tun_file. When the ring is empty the queue is also
> woken to handle potential races.
>
> Without the corresponding queue stopping (introduced in a subsequent
> commit), this patch alone causes no regression for a tap setup sending
> to a qemu VM: 1.151 Mpps to 1.153 Mpps.
>

Another call to squash this into next patch.

Thanks

