Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B9843CEF7
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803563; cv=pass; b=VNkMzXGzpxr4prcn6b7yPaQ1mdEcKrl7yMAASv9qb5T6ASWj5CO4x58V1WesLKIiUSohOgYAf3NJhFNwb1XaVKLhNBw+jiYJiEnsrcxxbR+qyzOQGSA/AFwNYbilKwunggGxD0h0l7M6wmfqB4vyx+GVo6RIQzo4ZVC2EbPRiTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803563; c=relaxed/simple;
	bh=fKQIqvFI+qnPLn66kWfRVJq/EdEMbY7GUmyED5BG8ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZBms2v7H349O1QkaIOM8Fi1rqaPJf6ONaLFKFeO6AHdT74bFbohKdP1FIBEOQ/BquMwv79WZ8Gm58Jzh0o1KbGiFwRFG9e8c+etF2ebDOt5QnRSBExiRmXacpILovRo0MnYDx2vx9tMLRvLBnW7DQqDBTUVl5oQbduE6wSRGmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LuEIcVnH; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuEIcVnH"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ed2a06b9eso4058827b3.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 03:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784803560; cv=none;
        d=google.com; s=arc-20260327;
        b=TwwVOHhx8cbye4XHu3f/lRLpBDIbZpnlDpCxsLpO3cKhgEI7xBafd8E4rRKOjzHoal
         nm5YIDwHGQL9F1K6GSBNZ1rAOxNOzj1AGkywyoUbBjBWazza4+RtXANt/FX9CrftjVzp
         /ht6ECj2mG6G9tt5ZvqLyIhKX9XJu+YST3hUQVOhfT/POkXVviyTjZ2lQ3F0st9AVtfQ
         umWKvzO3tPg6VZ4JDTPnOq4l+/UC+QBYXAebFRsPCqWtK6obMNp7IwpBUYDHQdAH67gl
         5FD+ncvt3HUQlrvoqSBFbnzXN3Ck4nYyA0kMLyiBVbOxCZrhjt0LVOaJUCUiDFLNicuX
         Lz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fKQIqvFI+qnPLn66kWfRVJq/EdEMbY7GUmyED5BG8ZI=;
        fh=XCY7Vbp4cy2elZbzjLL/vKgBAYyUGlZ4fKwF1xAfUU0=;
        b=mZHgIM2u3OjEXgIgJpI2y3yiCIR5AoaDQUPMiDxIVpmL0f4wGdkOGWkboyS1veyMMQ
         /mRgXeZuA1rXoVyfyXekZBber/Es+p4l9do89O1SWdUaqsg7Wak0Emuuvd9VbWAizUFI
         jXxoq7p/wD1MJQ/KItU/pDhpMssR59B7ExT08khheswV5Jka6UPTsO5B0wGBWNQ6G0IS
         o8KkASifFptD4Iqr3WSLfdhf2lw1m1bdx2wHSj3KC3aENw2At0istdILtkeZ0bb30BlH
         USiXMJySoGgeq2R4xIBk3Gu1eeKYZxWXH3BSmD5ll6Z0tOPOHJ4keNH9TkiEKju0t4ma
         zNNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784803560; x=1785408360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fKQIqvFI+qnPLn66kWfRVJq/EdEMbY7GUmyED5BG8ZI=;
        b=LuEIcVnHGkTl3qkGq8yFmSnpzpKYaDdJXP4deUE7HXTRB00RCxiZu20FnDGmjO0Jjb
         XwgtmAOY+uxSdjdU4hLqs/TdOsp8HNR8NbQk/xmKr/7FGS1apOlUfaG2j/2vaXz/m57K
         W7pveIz89gtYdzkKqbL4wdfr7EFaoPNba+yArKiCnlLztKT1zFyuu+0z6zCxCaWVebLd
         0KR4FfEuPtPjtmIWx7e26kIWd9g1OI3pCiMmeSUGwkQYUETYYB66NWRkWkaU6CyXaeuH
         egCvZaOjzvUt3SXggvn/G8mYaqQNHjReLzu0k2KzxlK0hJy0No0huG+bDoH26lv0wKyy
         MBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784803560; x=1785408360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKQIqvFI+qnPLn66kWfRVJq/EdEMbY7GUmyED5BG8ZI=;
        b=QBI08qwt8nckA06dqxJl9VnIGeZruOXaRuJJjyi3+vRc4SZM8I5FGOUQby/8yUNJJu
         x4ELkm6Bcd+JW2WYzEchNFZoxcutvgDBU4/iwrnJE49dCL6nnlrgycelk+VOyvP3V9fY
         rfsXT6LhjzcF3v4jwsYWDq18dfcUp2IlzSKcIFZt14N8Q7V6nnjgm0E7AQIsUZ2G1103
         NQrGF6uxvAuiyULp9H+fRJ0kYx2XSBnswFuyWHOHVVHCM5EBiMUko5yEIxEzk/JuR7OY
         viv7/VbsgQN4l27z/BsqZk/h81HVi1r4W+Vl7XCI95PFfpY1cZz0vriitaKHnqhdKS3L
         Tfkg==
X-Forwarded-Encrypted: i=1; AHgh+RojmgayY4W8PWr/i8/hKThKA1gM/5xYzPXWBS8Wt1Z0z2fTkSTYQLGhF8uorGpxx8/yWdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynfzai2/4wQE+sWWkRXVLXnTWPAtvZFqrE2RLtiqP/FsX3Y1Fx
	QLb29EyoYPPBaPup1PhkVzCjKW+iI5Wv4hP7w44MePidjo1J7peadgyRDD6QV/K8xVQ+0+NGNCn
	5tZMRTaDERWRRgMkCkhagZfQrFnNqgzR2tjxq3whDHQ==
X-Gm-Gg: AR+sD12DN9Lvn4ro7D20PI5me+g/2JaQBZ/jZXzTxU+91AR+8oy7YCJKHCqVcOJ6Qe7
	aNzfXuaXWJDJ9ZnODxykL//WrAh65SqRnQrV0+evo8H4P1xqXMNMY3FZA2uy7Lz+DlB4+I/OCSW
	IsHngm2xPeQDbxy1AZTL4+douMbPn756FJ6gcwos90rsz0upvo+EjmAFMBuvn5W94Rqea29ydAi
	WKgCrUf9yvavWV3wR2f0gghN4hQB6gWjVWb2JzfVW5+a7L2Q5pli6WLUGV3VSQ+X3HW+TfqJPSw
	p9fuHkIUFQeWHvAtPddr50ILoFE9qQbdVGyIYOOPQlf6og==
X-Received: by 2002:a05:690c:9986:b0:81e:2b86:d75a with SMTP id
 00721157ae682-81f4c2fd99emr7042797b3.55.1784803559620; Thu, 23 Jul 2026
 03:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
 <e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com> <87mrvightj.fsf@pond.sub.org>
In-Reply-To: <87mrvightj.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2026 11:45:47 +0100
X-Gm-Features: AUfX_my1yVwqDYBFri7PHqiSbZZksCRSQ7Qda_pMQK4AnsOEZwerOgkNdV0ZEE4
Message-ID: <CAFEAcA-Upx9uacBZ8nq3Co5csNqi-nHaTOVX7t9kUzDW-CL5Bg@mail.gmail.com>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
	marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
	"Dr. David Alan Gilbert" <dave@treblig.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	"open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2026 at 10:46, Markus Armbruster <armbru@redhat.com> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:
>
> > Hi,
> >
> > On 21/5/26 16:54, marcandre.lureau@redhat.com wrote:
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> >> (inherited from memory_region_find()), but both SEV callers were faili=
ng
> >> to release it.
> >
> > Comment orthogonal to your fix; odd to have a non-monitor code
> > call an undocumented monitor method.
>
> Which one?

The gpa2hva() function, presumably. It does seem a bit odd to
have the target/i386 code directly calling this. The function
in monitor.c works on the system memory AddressSpace and
assumes that there is only one kind of "guest physical address",
because that's the implicit "everything is an old i386 PC"
kind of assumption that got backed into the human monitor
command. But it's not really something we should be doing
more widely.

The i386/sev code looks rather odd to me. It seems to be
using gpa2hva as a way to get at the host memory that is
backing the guest memory. Why can't it use the usual
address_space_map() etc APIs for this? Worse, it looks like
it keeps that host pointer around in a SevLaunchUpdateData
struct, and it's not immediately obvious to me that it won't
go wrong if the memory map later gets moved around and that
pointer becomes invalid. And it looks like it writes into
guest memory in a way that will bypass the dirty-tracking.

thanks
-- PMM
