Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD323BBFB0
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718645; cv=pass; b=Spepbl6dHTe4cy4hV38oVSp5ZPGMKlIZF7myHquoFSiBGYZjJghVbRbwVG2rANNPeEkdJsoWX38vue7Dmj2RFwmcsDW7YdJQQ5uIyrobkSe8V9EP3T2isx9iaiLEOVd8H8gbvWncRKPsyeti8NQgvjbi9rljvO/LCWFGpokVdxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718645; c=relaxed/simple;
	bh=QEbc3CpFQ1PPCLExeK7MkMzZrEkYFgHC1uQKWvOBDWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gotiUP5NTg93XRgVGHvtj4rmD7STMRTROtezmOa8mD82VXxSnofUX0Q2cVqwFyoPrNRO9PSwwxv/+jxZWdG2en82nsDNhsh9XFohw/r7Rx3GWWnkVprONWoSVbqRaTodlVKgV6lmlC/cmPx0jlHeO6MfRIf3Des/SwlZKVKTMaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISE11ReL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mVFyAwVz; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISE11ReL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mVFyAwVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784718643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEbc3CpFQ1PPCLExeK7MkMzZrEkYFgHC1uQKWvOBDWY=;
	b=ISE11ReLknSeq8ZXFqLlka9U0AS8MbxtWeUCb9Y0F4uvzq3Q4nsc2SU2L07Uy9vyUM2JdI
	M6BeHSt2nvH8MwH8SoEIrYEZ5mYftaLCaV86buBkmlWEvutCVUICYfeFyjrlr7Z/SMj5rd
	6uStWbNz2w1TJmSfyqZc0SSonKKVxbk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-b8iBuGe8MnulI2bmPB-uZA-1; Wed, 22 Jul 2026 07:10:39 -0400
X-MC-Unique: b8iBuGe8MnulI2bmPB-uZA-1
X-Mimecast-MFC-AGG-ID: b8iBuGe8MnulI2bmPB-uZA_1784718639
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso15173635a12.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 04:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784718639; cv=none;
        d=google.com; s=arc-20260327;
        b=pUjmr7HfXXWibsXqr1PcXUdDQtS/PpN1hp9/gPbuq37+o90ASJ9FYyKLBbxbIqlIKq
         AE68FWFTPzpn2EENAQgxCU93BZ+7/ZSQEztgqYp87gj2b1GxOCTWu9heubRdNDZP12fS
         eB82qqNVORmpkh6N1QxZD6DMWTlt8qvACLKLqpZIx8YmwqUqtmnJKP+AZASO+A6Kjxfe
         kdx6stAM39qY7K1SnMJH78ujEl6rVQnCLhxoEOa21/A+BkH+1cg0+GvzLK0hMcdda4VT
         OJBnelKbeyI694c6C37kOeguXXh8UbG3WR9kVTqQrCc43anpXy9wIbGk4E3ahCvjIrPi
         iWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QEbc3CpFQ1PPCLExeK7MkMzZrEkYFgHC1uQKWvOBDWY=;
        fh=fKRhxJmPi5yWObzR151s64E8A6W3yvKMWtw2uMv1Uzw=;
        b=ryboVW9FKePJLM2rWsr79maCM3mNKit4lGCi05rp9iC/asgcs47ww3vGV65UB6wRyD
         JU0n2xgJ7tWpNiVQUsH7dToGjICEQWs7EeA1xi+kPcqHSQvwxlUboXT51DweOxKkWJYf
         zWOjI3K/vrVI7j0AbhANtb6R3/J3zLa6K0GLX3Sk5fGVieJXQJpcS5SnFdGP2g0PE0fk
         xETlSR90Y65gOHoyARGzeOaJvpnt2DftM9WdZiXE7YJQ4eJ/2yNUmLzeew4QmoWmhj0h
         1b4lalGuDWBNrdFhA+Wpf5L0qLDPZu9FZBsmJDZgzf1/EuBBF+eLYMDvZIo1axENLANx
         66SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784718639; x=1785323439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QEbc3CpFQ1PPCLExeK7MkMzZrEkYFgHC1uQKWvOBDWY=;
        b=mVFyAwVzIPuaicchaiInpEhJ2AIGvcERZo85VZ7b7EaIj6yHXy5CwTKjL7LfXLQeWM
         c4RyNWT8quA2gZoPshgKNHaap2yM2vtdGaRj4ydBkhanoWfgVxS70xIwSHZv15q6912I
         vmmRqJoF2Ct6IJgBq5GucFhYlgG5eeznuw4VboyK8yXiAMv5UtbwfVLETM0GUa1dk3px
         /3VYA2LwFhzrgbpFHXnnEtli7wKDp3jwu8jencJk1r02B/kPXW7rkQCTDjB2bN+ChTFi
         Wf/8U9YVwyb55XvHHSVGzHHXVI+wuor78sjt+z22AqHiWxy1TFzeM7ldRwzj853hFqcP
         bF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784718639; x=1785323439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEbc3CpFQ1PPCLExeK7MkMzZrEkYFgHC1uQKWvOBDWY=;
        b=X3oTc0ebiZzRrkMhYzfBf0Wi4JHiXsjhLd+BmnHuGQ2jEPBv9D6Ov/YfQ903R7yX+Y
         dRDMkqeKzA3A5IMTTDdMRAZe84QL8+Mmew3XYEnUU0N06xQ3hGnJkm/+eXSAr7b5KiWC
         DeAocVrMNFFiDLtmU7Xy+zmD3Zcg4cxCZEJcISD/MychNj+Bh+k3HUPREfjtjpjYVd5a
         4M5zp/JHxr0dsu6O3dKdKLXGAClDj7vTKbrfiF4X9kfK/OpNLdG2Y9lqP5S9sCeBFeV5
         gosnOvnuQqOT3frbsD+G8b4d9LRf/OzRMojZiNIpen4Bv7IULrSjkoFNt59ZwgY0Lbn0
         G/aw==
X-Forwarded-Encrypted: i=1; AHgh+RrNlhv6tLRGhf95Fa/JsTzhvqniPBK16szKldCXUPksGip78yVV89SS2VInmJRYCi+tD68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70H0Vy9X9LZIKa8cEDFYosd2rBxNaJ9p7xOghMiQs6elRlm68
	c7WpLbFXu+20bQvlLgwpqau8E+Lo+ZCXkgEskisRxfve22zihuQR7t3U1w7nfR1PHi1PeZztK5q
	UaNp7YBro74XauurQK171v+ld7KSabXE8Lu6hJKnonciaVOdC/lFNZJWAayu25N5DeGE+MbTbb4
	0nLfgspXKbfARM+KMWLJKAvUw7vKhhNO4Im4iG
X-Gm-Gg: AR+sD10cjQLsoX2EppSkStMl+6lIiZfzIe+UIFK9Jl7nArUirwUQk7M6i2/57A0pRB/
	Sk2vuwyH8IRC/T+Gv4s6jt0NqUnAus86WBTmLBp6NAVwQheQMFfnncdiG71eWhNNJ3EeOQa8mq/
	Wl+dH6ozUny3AHOhwexfsZFGK+aceHTRB7LBlwF/NSO4g1CC1LcL2mIwKntGAv2umi/18Ns3jze
	wl3SnGru3JLoiHq+wmrWF1nxWsrDh0CNnTywiG6LvBDQy2FOe1RhqxTHGevfn779xzQc6Unsxuw
	0Q==
X-Received: by 2002:a05:6a21:c14e:10b0:3c3:bf10:419a with SMTP id adf61e73a8af0-3c3bf1044efmr20102412637.71.1784718638578;
        Wed, 22 Jul 2026 04:10:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:c14e:10b0:3c3:bf10:419a with SMTP id
 adf61e73a8af0-3c3bf1044efmr20102388637.71.1784718638166; Wed, 22 Jul 2026
 04:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com> <ag8yBA7jpCo9dYR_@x1.local>
In-Reply-To: <ag8yBA7jpCo9dYR_@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Jul 2026 15:10:26 +0400
X-Gm-Features: AUfX_mxpQu5__smB8QJULCuNGTbbW-00dXUdJygGM95v3zx0hmeGOnUKRwfWp1g
Message-ID: <CAMxuvayB3ywMQqE1rE0M4sKLLg5H0H8Mh69r=AcA+wwfQqT28g@mail.gmail.com>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	"open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 21, 2026 at 8:25=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, May 21, 2026 at 06:54:51PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> > (inherited from memory_region_find()), but both SEV callers were failin=
g
> > to release it.
> >
> > Fixes: c7f7e6970d3b ("sev: add sev-inject-launch-secret")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

If nobody object, I'll queue this patch before it is forgotten.

