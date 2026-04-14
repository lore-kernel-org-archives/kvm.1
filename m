Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3B39FD4
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174952; cv=pass; b=S8+TmfdQmExC8Y8+s6VLdTmWfwhTe67WNEtOXKKAPpDejU151miKkVaoEWbUFhDf9jlZcIYcOJyWk/l/GE8mMOWJHQdj+W5emjuTleFYD0XL5jFYePWTwXLZspovVdVT2xr8wQhC6InmZ0TEcS/MTRhZec8xGKOCGZBi9B+K5no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174952; c=relaxed/simple;
	bh=WD8lG4R9tT/bXoqr+9aOkFmOeNamTtfKssxBVYK9kJg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WQE+0rYVJwPOxjkadtiLa9GUuyzB0lWPSSG5IiAy2Pb4Jr4ghxB7PYNdQvgVPj/chYRwdBjxznQVt7IfkZ+t5JO153haBm9y15POf4MY9LaeAwIJ30g35tL6dEMkUz6a9aBm/SGO09J+c1LF528nOxWnoi2Tj+HPv8UvSc6sjyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XFSfqmOf; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFSfqmOf"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6501418152cso5194880d50.0
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 06:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776174950; cv=none;
        d=google.com; s=arc-20240605;
        b=gk/ZChgC/R55XvdEheEguGi1pbybITMLJGckoLP20DYcVlywAOr3jmDmZT+SQu3j0D
         myBBWkBR1HZlbIHvNfBOy1ntIotfjzvFerIPDezeYJCoQoEjTQPKQZ4d1lcSIXFwOn74
         9QP/kiKg58MoHh2LrQ79IKVUSc1yX7/a8BXN8LWp5UR3TK6FD3WHQQO1ZpgWLc2NokyG
         KJB+Y1tV0m7t32NzcF2Bb/nz9IM8f1E9tTtath9QQxRwQtknFmxobQkz+7PDz4epetCP
         5McHMs5C08vOkjlKK0MERrJiwqNO/kyRDO2U4NX1zn2IJXVXgCfclG0skgntjNny4lUK
         Ng+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WD8lG4R9tT/bXoqr+9aOkFmOeNamTtfKssxBVYK9kJg=;
        fh=P8Ghf/g2NFcZuaDV6PV2v5LyV4tSlOjworTXz2lPdnM=;
        b=Sl91Y0bxEEeVoe0EmkQH9zA0OFyl7dAWhGuj6Txuun3A/Dc60hlTERSirmavaPKbWp
         k4iAGCe/77Y3/d/TXXmYjThxLTt+4WMAG5jQUOhIsvykGg+Tpk2TMxY7RbScTwIKIfe6
         dNkCvwNE/u7rtxueWQhJx20b7RdeEo2ktblAQCovN2WYaOnAZLi6cTnt4cOH9HBrje4O
         bKvtinfQj4OcPf211PimwuvUk2ZL3iyFCv2eV5kw3EmDj4IMEMi1UCqj1ALWedEpQ8Dy
         iVEOuf8v2qSFtmM6Dn/LO56FEFtTqec9hi8bkM8zRBYzkmr+tNeF7zeCMpVxz96EELKk
         JyCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776174950; x=1776779750; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WD8lG4R9tT/bXoqr+9aOkFmOeNamTtfKssxBVYK9kJg=;
        b=XFSfqmOfJ2bMVCOpHiFI7H9eiLM9+Vp2T2VFXOCOzbsB7j9Dx0+pKOm8Bv8dtP/K+t
         yUP/P0MAC23nbThWbsYrQs7tatcT3W+7YIsAZrOPwqSeRStjXEj2Po+cPgrZxDKiKexM
         lf2iQnJOWt4vKR5+4m+QSWwQ28FSIysqddBmCXfBPRs7Bdbq7fxecKGMeNRJ3GwvvoQl
         1c1tC7QyPTjhW/uRzmsGRCjdAz92AoiQn3OxLYScGICQ/wWH4XGdoWMGBMa+gPQyrT36
         8YGPG8Ov6mPx8AAG+0nY5Aiw0BNFMg8AETkdVBwoKdh9ljh11lYBoh8pkeSZ8iSv8Q77
         gN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776174950; x=1776779750;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD8lG4R9tT/bXoqr+9aOkFmOeNamTtfKssxBVYK9kJg=;
        b=B52Fd4UT4UqcZuonXZ2SeLYBv1lH4aIvshg3H4fQKJJ0oV7oXB5B1+y8/77xiB9bHI
         4cTxvG5SfYiArr4+uWjHkZNrgJRexhozqJB5BlBVcjAbL8gNm/Tj1hRvRU8bnOBkgiqE
         fh1m5/WCL8GnBmkMaxEIvKfLBWCh8vb4wbZ5lhnZaI49LN2uHSnKeOFHPTG/AA8EKc9I
         idsWlwpfA4RajGd2sv5NLP2E9mAkT/6qp8LpaBC1o1MeZyK9IJS77dsu+fFDCL1q33Ot
         GRvnPc+I3s1q2YdRbKK24/XM79JA9ccKf/yS819lMCLJGgHVNmVHDBYhD1DSZTyWkGZW
         zFvA==
X-Gm-Message-State: AOJu0YzYNvxylaieurtm1LUZfjCMP19r6FPTlTaZVGVcJdXQGHQsfskb
	oxbSxhGobaS58z99tGTWXtIYmaASheWAssRHjH1vm8Lm30LtBo+/fdxSjJ1IgtlibZl5kICBGfy
	jg77W/W80SZJR7c9aivJ1T0Xv0fT6+b8e+gcA0IBNvYKHdkYr6HOkqdDepg==
X-Gm-Gg: AeBDietuBhS+WM6KfwETI8KpfjjEGEa3To+JoyDL9HmGCaojYtMC/NaPDwD7hMUMQOU
	ImQJ2LU8n8ZNa+eAvpQfKEAqtyy/PnMddsArvuKHmZr0Yw/hCOPOCJAKgxchG51cAn1EwSfJfNh
	ZqKACf8dsQLJ7250e51qmTtgw7uzL3vfdJs5M6eAVJEzSQc5AEw+lQUuYM9bVBiqR0HYM1kBxG0
	N7bVOTinU4a6WqO57HOQTf45zWYlAy93em+qoPt8Y3UjKQ9QqOLdfwIWL17JzsD3XicEdVfzogi
	SVTPG+/3lOvyGKikbz0S2UV5fWkNXVIdAWqotpjzPfVAtm5WQVvGul7MXj8f6gQrTX1potEKoAk
	w2w==
X-Received: by 2002:a53:5111:0:b0:650:7841:6dd with SMTP id
 956f58d0204a3-65198b48595mr11733461d50.31.1776174949866; Tue, 14 Apr 2026
 06:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2026 14:55:37 +0100
X-Gm-Features: AQROBzDT8ub_T4i3syTyrfey9GfVpI6BHPvMg0DKFG5a_s4EMp7pzZPCbDTjMIs
Message-ID: <CAFEAcA9+Y63J2YvKK7OKmNEkqxzY7abRjPoiNysaP2tbV5TW5Q@mail.gmail.com>
Subject: Save the date: KVM Forum 2026, Vancouver, Canada, November 12-13
To: kvm-devel <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

####################
KVM Forum 2026
November 12-13, 2026
Vancouver, Canada
####################

On behalf of the program committee for the KVM Forum, I am pleased to announce
KVM Forum 2026, November 12-13 2026 in Vancouver, Canada.
The call for papers will follow, but we want to give you the opportunity
to pre-plan.

https://kvm-forum.qemu.org/ and https://kvm-forum.qemu.org/location/
already provide some initial information, more will come soon.

-- Peter Maydell
