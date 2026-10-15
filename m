Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39EC4570DA
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100905; cv=pass; b=E7ChjVm9bV82+tyfI6qzBYRaHd/GSWfNDAK24p5SoMof8mvAlE8yxAO4o8SLsocz0nyQu0kGxgtM8CHGUYrvXcbkOWFPRSSxyQLc5JpCHxMYeUbr4cLQQBVPtyjYvwN2ArsmwlL1qra3QXySuewusvaeR9BWmspjPizsTpak7zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100905; c=relaxed/simple;
	bh=x9DfZcXd5QJzvCjBswFIK3WX4GL4pOPJHTl/njeMnVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMPmL3b307UBAqhpT9YUK8M7FBkjUzCzziH2GkdbkAM3ZSznn9Tdro/TQqT7LGEsEOcimJ1Up6DmC4jBkm7jyNWh9G4oERicNIQhHkLdiKxh6X+X4BguINJy8KZ3DPR4YzDqNmy0icCPpcsr9YWcExBxstVjQJQKRtcLBeMKeq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZn02aSo; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZn02aSo"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1560a12.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 14:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792100902; cv=none;
        d=google.com; s=arc-20260327;
        b=ApqQBcz9ZfJsDrtSJFczvRl8iAmoSIz6zDy97eLuZmA79dHJrLlQQRxrl2c6LINcj2
         gWBDyrYc/oznxreUMevTFNoGtfvEotAqAWlnvlHjMo1fuPs5+Ii2Xtr4BqRPME+szJsj
         Sm4j6iBILM0eSHZKAvwZihka2SXjuq4pZkCc1FqZXk2JVddiV/XXUlfE6yAkLLIXNsMq
         IUrcDnlTF3yf31G4yXICvpcGI0jVp/CtFjkXwxtveedSaXq69rjcWV8sqYEVwHNEddUh
         zMly4Az39TyiolTRKQGB23je6F/9dGkN2AtLMcPxc6JI5Q6irlV3lLUbB0HilW2S1aQZ
         LaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vh9rWF4SvHNqcgCJ7jUJGPeOELEufaBIr6WXtF+34n0=;
        fh=5NvXAcauV/uDbUtRgKj85U+PKufa43dB2+lnvNhgn2o=;
        b=OQ/drsndDqjSwik+BqKQktW+xeAE1ceU0Lxo1Vy7S3FN61+uQcUZJn6uGWFwkFoK2/
         +fTkbUdTcm/4PtrmOBNz20nYozrzP0cVyYv2QaMJSH7T+TmOLknHjS///b6yLwBDTp6H
         QlRdc4YKGkgutbIO/DInKhNKzt3c7+kBL6KDCBDHsyfYgVXEgJ47eNhnpHb9+i+8vh/+
         mX2Clg9Ba6Qf1E32sSwVxm4pDYIhkhpoPZx2odB5Ig86mwWISfIrn3bNHWWGv8W4wO+7
         wgm0GMwqA4uIMHlmzikJbhp2bSIBBamlWSkFOnOzdHkJJUFhgKigva6CARu8hJKlWe/t
         ZaAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792100902; x=1792705702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vh9rWF4SvHNqcgCJ7jUJGPeOELEufaBIr6WXtF+34n0=;
        b=jZn02aSo11YVn+Ty/uXNLpeexzQJ2hT+o4qliN1S9FcU3nZ3jTczPDIrrGJHieUDvH
         35gq2uhocSW9NCSKwWFeSyHwzEq5ebmb08E5KPATqF+NxsiN+Zszxi9Pvek2z1HIF/d1
         JtMFHI8BHwOEahtbmodawgnERW2XdWU8/NzAV1zcNfmV6aAWRV5BtBHvueruDIDI4z6n
         s4osdudm/EiBa4UfbG2xH6vpiOQJSqr2OiJvK+xczeRMyJ5kM+AI3AnBLHQpqwj0cu3g
         IZ7XKXgnvIRxnVpDgoXgA4RGidAiBnKYWP0JBbI4tMeuehQAVDFfUWWqIf2Idc90hMON
         x/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792100902; x=1792705702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vh9rWF4SvHNqcgCJ7jUJGPeOELEufaBIr6WXtF+34n0=;
        b=xavJ0xsP5HQB0WqR7UIgSBSG/OkZ7eCBZkIwteBPQgJ3wN4AZYF/0kxnF/32OdRgxd
         jKQhTr6zODVsnikbxfBbLKStPPjkc5TvLaWR1AaIeakFDlOhDm5AG3FX/iAz+GKl/puy
         8B+L6a7VcDIJpgWp2td3mTz0UBKtEpekmPdf1InVYBa3RzqdFko8pq5sTvviVyOK9YuA
         /Mp9zCb/iPC6WADq9fM9l8xI0wiYp/vWJvyrGh6hDbQG+JDfHmJEEgq2nBOWRl+8lrOz
         7Za3RviV3bDP84+H9QLhb7kwnVWXcGJJts9Md9BRs6rpUCnmqSg7UQ4wWFtbOX+sQ7b8
         M4KQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0cK02KnWaYJUMVIwI64vIG0quLEbb3HVKwD5Gr+vrCTwAQH0zoWDF8Vm5ZPWPhxsjl0w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKBD8QXgiEMlq65c6O+Sr/t+SaMGsvxugzJahmYJpMjilKYcZ4
	2nZ5p9uuE/RI/D+gMcPQoxniXyVqHaqsoxy7fjVGW8mXtWMm2hLuRTo3npU0MR3X8uQwCbDX9SM
	Apm7MS/oYddEeXcMxyXo9h8T5Tgv/RLchLaIiopvX
X-Gm-Gg: AYBFou1u4JaKhXc5FYWXxwowFACzVBGc1g6Fa2lXRawIKpWDYi7maqcOsltt3zaULuZ
	ObJ49ADw1WWa8S2Ktj1EEqWJRksRd0sPfwv/tN9m7c4twCXLFEIksDVa7MnxcqSz0+ahlD5y+ZQ
	xnw8mdO8kUSyldG1WJHpcJ4coh/vVqlxHsmOLEX4iTIW2ww+usc4TBAEcm8kJHzw+604cWRvglD
	S/ib5fk4dZXnYpCo4Rpvc181mRNJGmn+4Wkv/CcSHkYGgzlkldgNk9N8iNCyVr31+ZtnAP8CBYr
	25XcXYyHlK3W2uJDAynqVPxx5jk6TSczDu1rZTREU+HK4RvNWpGq7tk=
X-Received: by 2002:a05:6402:a210:20b0:6b1:c3f3:225 with SMTP id
 4fb4d7f45d1cf-6b38c3c7b4dmr6572a12.0.1792100901496; Thu, 15 Oct 2026 14:48:21
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-13-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-13-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 14:48:09 -0700
X-Gm-Features: AclHuK843m6jYK8HtbsNcB8aWe4AsVF0UuZPl_y8TP3gKWeChhKGdv7s9SqYTdo
Message-ID: <CALMp9eQ0Nxf=bR3tZsaNHG64267_5mt03MEO_QiWfqghJX6wjQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/27] KVM: nSVM: Drop svm->nested.initialized
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Do NULL checks on svm->nested.vmcb02.ptr instead of using a dedicated
> proxy 'initialized' field.  Make sure svm->nested.vmcb02.ptr is
> correctly set to NULL on initialization failures, as it is currently
> left as a dangling pointer.
>
> This makes it possible to directly do a NULL check on
> svm->nested.vmcb02.ptr before using it, instead of checking a different
> field, which is less error-prone.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
