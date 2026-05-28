Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D42E6CC0
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009437; cv=pass; b=mpaHfyXIXfNZWEYCZT9u4fF2A3IgEfymu1giYoO4ggsbpIIdd9D9t+3lv83A9u6pA8/yTJEKyg4OnnHZsRkb/ptQF0yYdaHuxcw4XUnN1zPuF/uJwa9F1bLHEj0/bF0aCBYVnLg6oJwce2LjA2jfpSDhhFACqPc8hW7juiA8MtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009437; c=relaxed/simple;
	bh=vWbXvzzspw3PUCkvj/fguZqvrGI5feziX1YdQr/48CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnqqpdY/seNUx7cm/v1W2MSNKjaagw7VEgtdOJ8eRr70tF7Qjbt1+9RymOyiUpy69F+LpUr3nnOonDZUpZEEoG03HkXg1wLrzqpTReqdhnxS7E10PoGlWASHxr5/MdlwoBG1JuGyY9azkBRjADTR+nTjONbXtpF68U5nll9OshM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cc+iSaJd; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cc+iSaJd"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e61648f10so9511cf.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780009435; cv=none;
        d=google.com; s=arc-20240605;
        b=QBv6DN15JA97fDrz83B8fhPxbO/HNUkZe+f5fLfHLx99A+qBGZ///fnNDY5YSVmUuo
         n5d52PdeOm1Um04WhJYf0NK7gvOayRg7gT0nfiyhOmz6x0d441l7F93kK/klVkm0xkDz
         z7IMLaZxrDrQiCucf6jwwjYfBssOaKJzI1htneYHAveRLQF+PCW825ZCU8kbGSmjORCU
         HXUi9ttUtMKEdKMncgFgKXX0o+GTY2ceeAIT0u9jGKpndDWLsyOCBwJ8c57Pj+VzaXFf
         RsfZ9LgRmJHqUULyiFxBjiVY/1IJ32M4dbffNEngqtJs8i+AKw5lT4FPucweJX2wuZhl
         t14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0K5XgsXEPT2rIhmxQhT9FI9tihtpMA67u4+xBfGrMqI=;
        fh=gmNbwqZ0YUzMCLtYYU62UXbejQntbaSzgWFr0jFbhlQ=;
        b=P4tu0Dk4csZQ4Hp5lJXxrWpyU/pxrtPiv+C927EAZqOo4pp8bN79zwCnekU9FtBwEB
         aQJ1Pj8s8H4CUdPiTyGFHFikbmKA2sIEuCltmVaeIocuC6te9mdxXdXxd/dl7bYSnpJt
         bGn2JBm2G9XrPS0yDAPbpDeVn1+aD6sLU9QfAYzJjUVXwq3qTfdHaAeORpJim7dbIhq5
         xTfiDzcaGB9hlMwjtnPa1178Gci+R0DvuRkzgN7xXgXwfA782MKN3Qnj6oWN7xcYDqCS
         h3uZo3+ZeZHblNfARpBJBqGH1dItajcx3u/Z0eylJce3YhTnrcOTnXY6NtV5xZ+5f6i2
         SwzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780009435; x=1780614235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K5XgsXEPT2rIhmxQhT9FI9tihtpMA67u4+xBfGrMqI=;
        b=Cc+iSaJdvc9gjqvXFoK8Q8b68E8f8fmkcb+0WBxM5Uf9OiPMjDw+ztVv1toCZwwaFI
         q48SvSpjcllN5UZUdb6vEz8jNpTYK/tORBYP+Am6bdimuYlMTLnoOhny//k1gny9hVgP
         bGjUVxlrHWillADHVJEBXI2l3d4HnUwENfRpvqO98oKXwB/uf+L/BhB0aD2bw2QXcU1O
         psCP4yETxQDXtRMYngeee1wh35j0MFhNkWB5DA/qvgwccd2wOn3OH+T5EVkkhdwyphWJ
         HCWmovS3uk8e8BhOgN2xjyftSrLWl9gfXgXYnacvB/lEWWK8BQb02sUjkuwXG9Gx4GeZ
         ucWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009435; x=1780614235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0K5XgsXEPT2rIhmxQhT9FI9tihtpMA67u4+xBfGrMqI=;
        b=j9qzExl5lMEI+izMCHOdoQlEEip3uZZn84zjCJ/A6fYyIcuLuWvD8yFkOAvafloyz3
         sslznx+a2b9bpq0LJ3De0v3+xBKERM3/ciYWIcQPReVI0HnCvCWezx823RP07edjyrAg
         pnoqpJU6XrcX1imRwQj694Du6Mn6MgjCLJALI2myJfxrUvkeeTZEW66vCYYfTE+3xF6O
         MFLbAyRJKaVFR2zJSm9K5D87xktK3F2hNSeFey5laeSXKlkCQ1Yc2+/AqfBA4FvFOf6n
         DtRts3XbO0o/yGA9Vtw3Zpxdd6dp/ob8yvsgx9o8HfypwpYSpaq8HUXpHr0wG1gHKxfi
         k/nw==
X-Forwarded-Encrypted: i=1; AFNElJ9Hu11KNVq1jmNXqgXbvtUEB/8tAEVjh1Ea07PVh3HbYjBQvhRWnEN3sohbMltZQb83rSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzms2SQ8rJxtdxUzYb9R1qw1kuz2Yz0WIMDvSoxM5HDPxbDl36
	W0ufaKhQVn7Yt8MYRnCSXFcUsbbd6z7wEybi1N5NugS6HLGpySXml2qiQOl1eJFf7J6HGo0c+9J
	5MBIPijTu7YFZCIAuejhId/YpPW7+6LZ5uyZS67M=
X-Gm-Gg: Acq92OEQbTAQ8zcR7a8Vy9cT68BpYNFt4Gc1OCjnq3vZULclOY8H9b/Lzu1Uu6NSW19
	x0w/sj+gkr7ZfbTFXCZRKNT6x/1g+rFn+xI3PSL161zNG8XYV4X3PXjWSSheRRyvCWPpd0HbqAr
	mY9A294WTRL0gQ7cRIq0BtF1MQBTyY9HuGgbqD6q+zwXyU53837Z6GyxHUQzW0bb39xU9TfKrf7
	ShU0GHIHLZ7Z8YTKSfyEZdH2xL7zuXfBtfBGvvu/Cvf/bxiQwXgeq9mPeZHTd+7YOOhIQHwVapq
	9HdMX4L9xL79Zrt0ykQ1BcLE6zJr8tAU0mnz40gPiltSTGQ=
X-Received: by 2002:ac8:46d2:0:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-5172df08eaemr1387231cf.15.1780009434512; Thu, 28 May 2026
 16:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-13-jrhilke@google.com>
 <ahZTTSEgpgJqvo1M@google.com>
In-Reply-To: <ahZTTSEgpgJqvo1M@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 28 May 2026 16:03:42 -0700
X-Gm-Features: AVHnY4KFn6A0nTHeNCtc8d8zTB7zjbusfsgYjnpupTpoP5ym4jrTFaD0_uB-2iE
Message-ID: <CAAdrzjtQBuQNgfE5XgO2WKe1OQbhUkxJV=CnpPM88q-5T3-79g@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] KVM: selftests: Verify non-postable IRQ remapping
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 7:13=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 21, 2026, Josh Hilke wrote:
> > -             for (j =3D 0; j < nr_vcpus; j++)
> > +             for (j =3D 0; j < nr_vcpus; j++) {
> >                       TEST_ASSERT(
> >                               !SYNC_FROM_GUEST_AND_READ(vm, guest_recei=
ved_irq[vcpus[j]->id]),
> >                               "IRQ flag for vCPU %d not clear prior to =
test",
> >                               vcpus[j]->id);
> > +                     TEST_ASSERT(
>
> A very special kind of hell.

I'm out of Dante's Inferno references. Will fix in v4.

>
> > +                             !SYNC_FROM_GUEST_AND_READ(vm, guest_recei=
ved_nmi[vcpus[j]->id]),
>
> Add a macro for this one too?

Will do.
