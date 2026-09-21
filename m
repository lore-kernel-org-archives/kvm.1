Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0623C2786
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031758; cv=pass; b=XKdrDSsLmlPDIxJqhNtNHq03mHLmgdoCVQlZy8H9NpWbDAB3EA43r24lSNLLrvda3KVFDKACyR+JvUxwuYOCiYAs2kgpuma7HsRWx8PNlijnpsoJdu/JE9bGrs3viyyaLjtUMZ4JHqUggZnBv8qMfi7EDpWW9Zufwz4Fs26WdXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031758; c=relaxed/simple;
	bh=8hnO3vaj19TugZkQX8EIHSZJpsMlJhW3HowugLastxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwkU2D5OO9T7CnrRjVam8hfnVYrO3RlMmIOer4COV4x8Md1HN08YySoB/xWV3lfWPBONc3YtUP/bbuFx1GtDWwiuTdxU7xRfAZzHNWM+SwKkki6SqbhdWo0yfoWjR09n3YuDJe2UyAXInOOHj9mkF/bd6Rmr5OrHkw2u87q60yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeunXRBN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4faWWJ+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeunXRBN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4faWWJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790031756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YiEeb39VuHCSEip6FWcapchdU3R3BfbzPibDVrVefRo=;
	b=UeunXRBNjznZZ06K1yuFt3cDmhKQIfkBuw2IsJvc3YQPbs0qLQjIiLJWWRqWZ9GU26g+W6
	zoM1yON1as656FJkT6Q2AD6SqaYyesjmffnnijfbO06QgZtVsqW/oQwEZxJGc5Gsk2OWcT
	xIadj717oLT5hZIfoTF8IpgrU1XtvxM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-YrL4qRK9PUKmdF8UCMAJng-1; Mon, 21 Sep 2026 19:02:32 -0400
X-MC-Unique: YrL4qRK9PUKmdF8UCMAJng-1
X-Mimecast-MFC-AGG-ID: YrL4qRK9PUKmdF8UCMAJng_1790031752
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49953abe51fso21033045e9.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 16:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790031751; cv=none;
        d=google.com; s=arc-20260327;
        b=SqlQujvQzJL48dpbal1AMxjG2p8OAPftsPjgQIla1rVDcta7heH7J5QWe+NApHIonR
         AQxfgKWpnHb1jBhaUHJB31lS3p5QIYgfYktMBYtUqOfBSIH7A+a4isMmCbAcqpBhG5yA
         +FvF/HMz1AIAENkExSMSCEyH0HoqeaZa/8oN+n0yE9wP8FshTVM6WOtwuwvyroBOXvsE
         Vx/geiuTnZYnvURU9+d7bkL9Xd369zTK2yxwfl203us7tS6zTxK8qHZ9oPCaYYmN75Pk
         hkgnREz6qE+YHoavqg25gr4PktHqp+nr4J2BLFxL5acT6VbUpJh9s7bZyQr2cgIfDrb9
         SmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YiEeb39VuHCSEip6FWcapchdU3R3BfbzPibDVrVefRo=;
        fh=LOownLlrgWkzbFT8TVROWB81F2Gufn54Hc865eGvVM0=;
        b=iAnLKR+fb2DnZSHExaYsaIbdzi1fc3fZrDdRmFxyHy/Ez0TrhJXpjDA6MB7GpNYicu
         RrGyH+E5vN0/upV7I9tUPGLu7MQlPDDOv61FGEAOvSGGf0eAq0SnU9CU3SfTy4NlVuKl
         wW9h/5KzRTeMdWhGmRrmGhBZiKigN7XrP0uINvwJWOl/sty7exQeJZdNMTQyB16lh+rU
         l3+KhQa1orQ7MtTwUKXbB479mro81rHA0/9ii/VwTJiLDBID2+aJiIh0ptvvEWTCBZeT
         6EjubRO0gPOV3tdS2Ejn1vL1Dz6bLBOXeI/ky1L0HxwDth0a+wbAfw/Csn/6yJRY9qo9
         NU1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790031751; x=1790636551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YiEeb39VuHCSEip6FWcapchdU3R3BfbzPibDVrVefRo=;
        b=d4faWWJ+IYkCUpOjZib2NVmSEeakO+ZGprnHBUVPwJQakkOnPH4W/fg7/f//b6w6l9
         SqKklAb57hNoHsFXL5PreeFxVY/AuyIq0dnQKfKy8Gh90N/gjPnZrlkw64TNkc4Va2is
         be8C7P97aGYVMxnb9aqanJ5QLWn0b4gH1QQYNkDlo8MBE+iHvJ/6KHRIyKrULmpIRMuX
         xnMNMacCT/x390gfZlsDEpLshQYM1IgTeP05tCigxGl4Mkb+Ubg5UqQTZQOz375kovUF
         PZIhikVW06BSAnYtwmojUJR69d4Q7PbUEukxNnvIoms6CZ1VtR5+CoSpqGRcEEg3OLIT
         UNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790031751; x=1790636551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YiEeb39VuHCSEip6FWcapchdU3R3BfbzPibDVrVefRo=;
        b=rMXUX+mAQct5RIn3V/tZYQpJ2mCYkdARc7MNXUjDxAaMGt+1R3BukmMxCh7DsMsUEz
         NprKnh2ZgUt3f8cR/Wd8zxpnmwJpkkztFNcKCPoM8EfL1pk4UKU+jJTU9I4/3mU2ZVRK
         lMA3YufANF2jOyEwOa+QbI1S7PrKSViHi08Q7EDoCnjjwNc5ROVf+T+T1nMWGEU6w/lc
         GWSBWXQAOioqX8OB7mdYt3LNCySQ9qcM7vmDivHXLGkpYQDsGI9xTPSGWnoVuyqr5W7n
         BOYd7ISGeVhaevbWwuiE5fdthJhw+JdlVgcl40mmcP+TvFpK/Ud/4JdlJliXBDvjIf9m
         HvYA==
X-Forwarded-Encrypted: i=1; AKwUvBwdsa2Jg+0eKw9GMXbPu0LCAtKTgdIFMVlXD9Ggfb7KQyiXjwk8kBUXdumLpbdw4TCcnpM=@vger.kernel.org
X-Gm-Message-State: AFuF++kVn/YGWO0eFAaWlCHR27XeNXz8PVHbGkNr6Amyh2RlLPryPVlv
	2+kaVyatiKDh6u2Zd8oStjR0QToAZ/z1THhZd6hU+kQOCvU+N/AFiBnSPDDePAvXvHNfhnGhJ2M
	k2GVaAKgNVvys2bByDXjJXmXR76o6QYDDQEYHglF3e3BMzGgq+ArkmEhocFOM2llp0Kpv9P4HhI
	wwlfjkmIf+xpZ9Gd6YMlvOZCICJNWm
X-Gm-Gg: AYBFou0FelGrf90QIaI+ugYMAz966bMraidTrrvHtu0R0/VCsKY1Ngk9U0NZSudSgHK
	B9BUIU9Y9J+kD1vz458g6/5HKfhlhz5ADtmp/E/joZsM/rKftE8G0ES3wpX7ox+uUMqk+YnoW3G
	3sD5E5xswAicw8GBFmUIu5Fy217u+nzJxoMmVRhApjWWqef74w2CLWGOEvpPs7RcizXsGPiMMfb
	NfR/KWFTUtnDYOL4vyIS1pQBSd5QMxekbTSUOyGPRsMPNIXtOFyLDojZRIv8Q==
X-Received: by 2002:a05:600c:34d2:b0:49e:6838:c813 with SMTP id 5b1f17b1804b1-49fc5865314mr133493365e9.33.1790031751759;
        Mon, 21 Sep 2026 16:02:31 -0700 (PDT)
X-Received: by 2002:a05:600c:34d2:b0:49e:6838:c813 with SMTP id
 5b1f17b1804b1-49fc5865314mr133493135e9.33.1790031751438; Mon, 21 Sep 2026
 16:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918094322.152817-1-pbonzini@redhat.com> <arG1Nh2yuMQyAdhV@google.com>
 <CABgObfatLAp3AsPktQVtVq0MgeJV1Bw+54i5LKye5KzjVPqbyQ@mail.gmail.com> <arG3L3TL5_xCBtc9@google.com>
In-Reply-To: <arG3L3TL5_xCBtc9@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Sep 2026 01:02:16 +0200
X-Gm-Features: AcwNN1WSstdLw8s658Gdk9JRK-z4AglKofqztxWi96AE_NjSyXS6cZYk_BJ65RQ
Message-ID: <CABgObfZTbj7cSUdGEcA2xgGkSgFqZ2NnNrHJ7+uYAHP3_9idqg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/hyperv: do not overwrite hc->ingpa for slow
 SIGNAL_EVENT hypercall
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:01=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> +James
>
> On Tue, Sep 22, 2026, Paolo Bonzini wrote:
> > (BTW, I would like to talk about memory attributes and kvm-userfault
> > next Wednesday... and whether those are two different things at all).
>
> By "next" Wednesday, do you mean the 23rd or the 30th?  I want to make su=
re James
> is pulled into the discussion as he know a lot more than I do with respec=
t to
> Google's use cases for KVM Userfault.

Either is fine, of course 23rd is better if there are no other topics plann=
ed.

Paolo

