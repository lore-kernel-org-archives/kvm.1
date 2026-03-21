Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD202D97B7
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774101126; cv=pass; b=Wx5wRNgb9hYhflF5wzmSPPBhRlkEOI2ngDasLZG/Iw1qZIsYsK4cbZF2T64Pz95WkgtZjirZr5AhRwZXMoxbtbmwiToMjJ4/4ZJul3pSZaKykQ4naydqXmRHZsdaV85krmhT4OPABFPHk7PcCUEDSTYTb4MZnBruwbwnMnOJE2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774101126; c=relaxed/simple;
	bh=Y4nwWfYp4xucEIMntwd3X11Ly5WLglecgL4wpFeqsW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vzm+SCzU/QtTn1M7Oi8kRpQ1VkOhzzmvXGvog2TFztsc0w5VHTp9PTOYXjTJytiA8z4CmLr2374huSD6T2cz1QaDUOlxgY2eC95v4hAvV8bU31Kr1uSRM+kJP7rVgoBC1A7hgvc+XCvhqAlKFdV+vMh6kHvJirOAZxflqBxJvDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeJ3faFw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nM6wNRg6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeJ3faFw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nM6wNRg6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774101123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bObhxZ2N+nOxpIIMSTF5HcjmnI3wtPS5QgJEe3YvW7o=;
	b=XeJ3faFwGWvrXT3TaVTsP26ht7lcqqa3n9JmuytF9gRPvr90DZxQgb4D6mx0wCIl4ukJ8T
	PgAyX++z2ZIq1uwyy37nz6RtQvSP4mckGpLHKY++MlvGkDWd6sZ5M4bRI6ezFdKNQ2MTya
	JdUBhtcgF1izSjleSdJIwVCKNXOafqo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-FBTgVPVxOg6sNT5_9jqwmA-1; Sat, 21 Mar 2026 09:52:01 -0400
X-MC-Unique: FBTgVPVxOg6sNT5_9jqwmA-1
X-Mimecast-MFC-AGG-ID: FBTgVPVxOg6sNT5_9jqwmA_1774101120
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b4e102d77so1752695f8f.1
        for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 06:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774101120; cv=none;
        d=google.com; s=arc-20240605;
        b=KF9KS05ZNtS3DLkT1ukI6g8jCU9XoDcLBtlUL5JemSUJdYQj7fjSJfHtCUJWHivQCg
         5fWp7DxmJQqkURMP/j5Zv5SaMd3UlezBlO0fLyiURFJ7UMZs3STIAk6wH5MuxcPhdlIq
         6DvtAmMzcBKICqwrzr+MF/0vkgDO52N9men5utCQ0QbT/rKnxMQsDLp4Aw93wXMa+zFm
         cPKIChWnsnQi0Fnw7W/vTTOoIeJFedMil+EzWegvuaVkAS8RXbLfKd/IMFlVfk67K6Ye
         Quxd4wNWperQJWjXu2Jbonu0Q7kNF6+VYxn4CwDJABvalo0Xj460+5CC4Gxdp3+RyZyB
         RsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bObhxZ2N+nOxpIIMSTF5HcjmnI3wtPS5QgJEe3YvW7o=;
        fh=mt4z7cxmg7xLHjTJLSvLoCNSWuxX8D1HJGngR0rqq2I=;
        b=kOconcpRyGUau0RpqWuKQVnICm0POkMPVrjUwOu/GQFFHZOvMd1QAUAeQLn3EEVAsF
         rf0zbhJXpcEUNHl+VHf91XChBy/svtzRmL8WovV/5Cggqbn/gRtAiF8pj6W4M0flZn4a
         EcyWkqeaMnCFGZsKErVUGVDOuJYjmhN0Ndb6qO/R6qzyXc2sus/gJazyad177ldIYYPK
         YlNacJzsF3PNITj3NeLxQmoryS4Es/YiM9wThcPVBlEIviJQuKcu/cgO0Mz6FmHX7jBW
         t1RLHwe9k2GYknWS4AJMZhhVyhBdqAxYksv5ZACHhDe4Z+Iij+zUESrFobxiguZF/J4h
         Q1ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774101120; x=1774705920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bObhxZ2N+nOxpIIMSTF5HcjmnI3wtPS5QgJEe3YvW7o=;
        b=nM6wNRg6dtEA2P1I0Xz29hZrCdXurZmNR+trvSDqrmR9cVfTItEm9gtFDNVSq6dzHc
         EtKqU/r4BaieWfN1SLdkUNiKubuelJrTIkUFpqvtCm0hcXUS8E3qJxf5Z9F+BbQ/Orbg
         wuJF6nvBtpT+PLS/1MfcfU9wHcYtrrKi4RBqxUfg8C5MaTxnCT15oEI1YaKZovpt3hFV
         LjKnfMxm40K7T8NVtmOvl/xM1VgZVlnzPvc3vK7UgDPCB1wF0X5AwF6ACSYAbpFkn3Go
         T/K7oTKtjZAcZ0RTbfGCSYsxJTywqZcFgzzOKLtBjT5Q2RiXOhNK7dOEnVmWFeI4L7Ni
         15vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774101120; x=1774705920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bObhxZ2N+nOxpIIMSTF5HcjmnI3wtPS5QgJEe3YvW7o=;
        b=byI8xLo8+3yGr+5SyFK69rzRnoQnCmsMmzRp8QYDve2D7JgPPuevgokZeyrXnToyaH
         F6TnhPFPjlIdB5xwswm9FnMcPMtvCDZK4/dJgUEVJO0X6s0L3ig0vzbYVjRPEBsDpCzC
         fO8pUvTUvMbpRM6f4WI1LQMxBcwLWrzDwmS6bztigp8zqUgWVOccR7I0VkNOxq5n9k65
         /AHGc7uQdGthG0/IDIOxflutjGkcDQU5stZCdQHibqjWrvBCNGK0a+C1StKCqiYOUGlH
         njmiKvPuc4LGIzeIoDb23DrcPqxWjizm7W9y2qs+8qULRY2gy5feexKU25V8VGY0SfcV
         N7cg==
X-Forwarded-Encrypted: i=1; AJvYcCXKb2X8okCIUUafHh5Fpkc3FQcdXfgbdXGppsOR1RU1ukOCKZPiAV5t4G/GfgQpcVvoAXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qS9fK6PS59O3TNsAFxCF/CPbA9ysAU4e9Drb15/e0E6SYu5Y
	GqeNR/H/IZCcW7NOxpH3bPDQiA6jRFdK2vcHMtwDskSSGAMThzmUhS8rp0uZFNVY4rBaLP1BnhP
	Et0Ml/9iS4dIjizi4myFzt+wyR7M7HoLl62PPptdCw0LXrK5j5/7O8+xxXEmPdHZY+7gj63zRX5
	ivAJwHqRFQVmjeL5opyy9Nubr6/L1G
X-Gm-Gg: ATEYQzyU0Gv4rh15tCno397MQ+M9I9snXna7bSO0s/SHBbiqrzm1ZsyJZMasGffqzv7
	Lm6WuzPtGPl15WH/o1oXIZyzSBpFPi/0M1Mckn/WQcwWJS2afvgpev8oVGM8tnGTkZ8s1xiMpN0
	HXJg3Tg/F7i8yeicrY3rud+rFuihYg7QS6zGmmCpgevE4xINwEHg6olYGRIUiBOsjF+CcJCsffd
	mcXbQEhrL4IMHf1LfVPlfwhpcnLu0nN3rJdalZPmL8eHBiUKRI2gNW69ySsQKm9epvrwgeZM1eY
	MFAE
X-Received: by 2002:a5d:5f53:0:b0:439:be04:13c4 with SMTP id ffacd0b85a97d-43b6423d85bmr9967737f8f.4.1774101120269;
        Sat, 21 Mar 2026 06:52:00 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:439:be04:13c4 with SMTP id
 ffacd0b85a97d-43b6423d85bmr9967714f8f.4.1774101119797; Sat, 21 Mar 2026
 06:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321000931.1947084-1-pbonzini@redhat.com> <20260321000931.1947084-19-pbonzini@redhat.com>
 <20260321115826.GCab6H4lNYIih_g0B0@fat_crate.local>
In-Reply-To: <20260321115826.GCab6H4lNYIih_g0B0@fat_crate.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 21 Mar 2026 14:51:47 +0100
X-Gm-Features: AaiRm506_orGCVkkBUjNBBofGv7pudxvrLzRAVLWZsRrPdmmsYcoEP1tTBT_y2M
Message-ID: <CABgObfbGxJYO0iXvkduFR=q=gyoF819pwkgJSke7SLr+6zCVZg@mail.gmail.com>
Subject: Re: [PATCH 18/22] KVM: SVM: add GMET bit definitions
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 12:58=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
> > @@ -382,6 +382,7 @@
> >  #define X86_FEATURE_AVIC             (15*32+13) /* "avic" Virtual Inte=
rrupt Controller */
> >  #define X86_FEATURE_V_VMSAVE_VMLOAD  (15*32+15) /* "v_vmsave_vmload" V=
irtual VMSAVE VMLOAD */
> >  #define X86_FEATURE_VGIF             (15*32+16) /* "vgif" Virtual GIF =
*/
> > +#define X86_FEATURE_GMET             (15*32+17) /* "gmet" Guest Mode E=
xecution Trap */
>                                                       ^^^^^^
>
> Why do you need to show it in /proc/cpuinfo?

I prefer to be consistent with all the other ones in word 15.

Paolo

> >  #define X86_FEATURE_X2AVIC           (15*32+18) /* "x2avic" Virtual x2=
apic */
> >  #define X86_FEATURE_V_SPEC_CTRL              (15*32+20) /* "v_spec_ctr=
l" Virtual SPEC_CTRL */
> >  #define X86_FEATURE_VNMI             (15*32+25) /* "vnmi" Virtual NMI =
*/

